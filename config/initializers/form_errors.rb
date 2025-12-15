# Inline form-field error messages

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  if html_tag =~ /type="hidden"/ || html_tag =~ /<label/
    html_tag
  else
    html_tag.gsub!("form-control", "form-control is-invalid")

    %(<div class="field-with-errors">
        #{html_tag}
        <span class="invalid-feedback">
          #{[ instance.error_message ].flatten.join(', ')}
        </span>
      </div>
    ).html_safe
  end
end
