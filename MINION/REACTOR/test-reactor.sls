#{% if data['type'] == 'test' %}
clean-tmp:
  cmd.cmd.run:
    - tgt: '*'
    - arg:
      - rm /tmp/TEST
#{% endif %}

echo-date:
  cmd.cmd.run:
    - tgt: '*'
    - arg:
      - echo 'date'
      
touch-tmp:
  cmd.file.touch:
    - tgt: '*'
    - arg:
      - /tmp/reactor-test