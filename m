Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADF814A0A3;
	Tue, 17 Dec 2024 21:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734471179; cv=none; b=UyJGooKixE2iM81i5YG1CnoFTcjY9uPiZqN7+mh6wnxkH2TTmxxz0754mY04T9496oo/QwIt6DbgbF04Mlvwj08KmiUW2xwr+wujy7eciOBBRSBsq0KG5Dhg92coFKGHiaxjjjbHmPgrxxkDBG9LxZVeV8KOlZXrx03TqWAbUCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734471179; c=relaxed/simple;
	bh=y01olJIiiz58OBvuQb4Xchk4Ysw7qzNgRqidtk9TFh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=e9JU+nwVS5WNcLCSW69J3z0Zquj/1tajoGQu9GquJWYXWc3s5t3K4DUsKyHwp0t6VL8BrgJyCBvUuBU5mYdIp8t3N1fVA7pVw6KMfvXbwUKDuZthjl1T1Wx19hDiQqRolTpduG1YMNEvABixkZLvcklH2iZnQVwdvYhljbwAWns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=IT4kstak; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="IT4kstak"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1734471103; x=1735075903; i=w_armin@gmx.de;
	bh=ohMI6fbY0XGp3mePQbkEBJk59gA/LmR7ErgSRphmFJQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=IT4kstakeRWcJ3y+pRUq985Q7VARSj8TNFi8PoCFB7jiFqLih/isb5jBvLdbUG3x
	 RaAigExpbbpoMy4o3dgN3Ou0sXomsJn1HpdbfAQvRkuj50hIpVWWNCbzLyBSQQqtL
	 /g+S9j7naCKeLe1GtUYTnBzYJxaG8VYBhvyam6eO95L/yc/4gVUqoFX5rpMRxnWfI
	 AIvf5rEy54Lyi8pA0C9/IvtAbOUl3AcPihfEXARLDHsTOpIlMAvvDq3OnU+P9H20S
	 Ma0RQjVIddSmn1JEo5klZ07fxJc5PhgmPtsIdTAskdPnSTYnkvyNX1eYCA4LSV5z6
	 WvRb3eYFSRoi8cidOA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([91.14.230.110]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MacSY-1tzSxI4BQo-00dWcV; Tue, 17
 Dec 2024 22:31:43 +0100
Message-ID: <c23c4c88-786a-4662-a448-deb006b7a03c@gmx.de>
Date: Tue, 17 Dec 2024 22:31:39 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] platform/x86: samsung-galaxybook: Add
 samsung-galaxybook driver
To: Joshua Grisham <josh@joshuagrisham.com>, ilpo.jarvinen@linux.intel.com,
 hdegoede@redhat.com, platform-driver-x86@vger.kernel.org, corbet@lwn.net,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org
References: <20241216103855.18457-1-josh@joshuagrisham.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241216103855.18457-1-josh@joshuagrisham.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ny5aAt4pmxMpZmr/RZWvIQ7nWxnGwn9wdFg7/DVNjcKE7THdvcl
 72agCoRQkRLE8xpqEKx4yGmLlVTXO9TQqTWxEs/umwFvb3K2Yrph5qNNws194oR5rhJy4S+
 8vsCltCO/qjvfvizj0BqkHTWyoavraQLeuA4p06Ww6NNSolcC9GEc0RuSJox8Z7x/38Irs/
 Pq2LLqU8rATImvI1bnmZA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:E09JDqNJyas=;V12sAkfR5JcnJKY/2gks5gIuFB5
 lhJeqwRl5OD8yWU4yxwrilSQ+X73V1EMl9PurUfB2YahMpdGL3QyhLHSd+UYFLFs8hTw4zb5M
 CWUnlEexdJeMi7qMDRhdrv4JphZG3yRgOLwdbQxw4W4ZsOkjdB8tnwpYvoNEqCU2uxSIYkJgL
 DyZqSZmM9ODC31ePfgxxI4ctGAHYqi/UCqgD/jBEBmvkjk5YtfJ/AoSEggz+gM7iu/y1d84mh
 fydGu5nSC8EF0xbSY0jWUl1mg02wtKRXzxzEt+BLf7J9OhHM7SxjfHu8NFBgS8HNT0KEVEJUT
 iQXKnIEEw8B965jfUAwbpzibyVo53QhqDrWOpY5BctL6OzOLa5VOSiqnov3gU4/8It0+Kj/hq
 Dn0iNWirOHwqYOB/rfogre0NWSLBQmx4xpjQ+TDfgF13C7En4Y6YGUlbl1zgka31m/dVGPjP5
 wDoO3BDks4gIYJ+WWiSHU4WTUWTFCTiGDIhZgSpGny2WZNnO4zQ/jZeUiWY4EQLFjqNy95Z7p
 5xoSV32PfUOr2vaUtqxcNjYflx5S5zfscDb1ahCnJ4SG27SjpYCrB8FK3Mpf4abypJGVVleKd
 PmROhdlkeE+N2sH5lE0TJnAWJizXh1dRNfn1ZgttxxxuqeFM5rW3ETj22ojxMTL/IBupNPoQQ
 2jD8laBCWcrO8mJQwB/cQnsc2l/m+hyr4G/q6/R9zBhzev4xG1XLcXE9Ar2jNZPGLe2RIUXPW
 Pt+q2NmJpwZx83WoiUyNenX0j5+Ol+XlJC5v62E7jxztSsLp0tYawVGT7s/i7iPWea7B3ksZ3
 yNL+wJmr0Os6UA9XQrV1K6uo1tIzB1lV5z7Vbd+LWPVJXUjI2/2SHv4elmPJKyr1fdg30G9TI
 Nil6sJOlo7aZyF1MJenYTn9WCKjvBiYOr8XIavkcA7+MeROOzj8qkvQNOSNEg26uHuiZ1zQZm
 unl7uX5fawmviq/0L6BFqMvCycDg9pcm9Yvmw6pdE8pVquqLvglwSVDJypMgcfqXrk0o1E5Ah
 0o5w9Cb7mMyHSUWWyhIuoyl64PW1nUDPS7xUqNQottDsMgRFRiQjB0xz3mSzvD1n8K/+E6dkm
 zPEsbB2cBrPW5pHIxyD2oESjh3RpMr

Am 16.12.24 um 11:38 schrieb Joshua Grisham:

> Adds a new driver for Samsung Galaxy Book series notebook devices. This
> includes the driver itself, a tracepoint header file, a new page in the
> documentation, and relevant updates to Kconfig, Makefile, and MAINTAINER=
S
> files related to this new driver.

Can you make sure that scripts/checkpatch --strict find no more complaints=
 in the next patch
revision? Currently it finds 1 warning and 16 checks.

> Signed-off-by: Joshua Grisham <josh@joshuagrisham.com>
> ---
> v1->v2:
>   - Attempt to resolve all review comments from v1 as written here:
> https://lore.kernel.org/platform-driver-x86/53c5075b-1967-45d0-937f-4639=
12dd966d@gmx.de/T/#mbcbd8d5d9bc4496bac5486636c7d3b32bc3e5cd0
>
> v2->v3:
>   - Tweak to battery attribute to closer match pattern in dell-wmi-ddv
>   - implement platform_profile_remove() change from
>     9b3bb37b44a317626464e79da8b39989b421963f
>   - Small tweak to Documentation page
> ---
>   .../laptops/samsung-galaxybook.rst            |  280 ++++
>   MAINTAINERS                                   |    8 +
>   drivers/platform/x86/Kconfig                  |   18 +
>   drivers/platform/x86/Makefile                 |    5 +-
>   .../platform/x86/samsung-galaxybook-trace.h   |   51 +
>   drivers/platform/x86/samsung-galaxybook.c     | 1380 +++++++++++++++++
>   6 files changed, 1740 insertions(+), 2 deletions(-)
>   create mode 100644 Documentation/admin-guide/laptops/samsung-galaxyboo=
k.rst
>   create mode 100644 drivers/platform/x86/samsung-galaxybook-trace.h
>   create mode 100644 drivers/platform/x86/samsung-galaxybook.c
>
> diff --git a/Documentation/admin-guide/laptops/samsung-galaxybook.rst b/=
Documentation/admin-guide/laptops/samsung-galaxybook.rst
> new file mode 100644
> index 000000000000..947810c5f998
> --- /dev/null
> +++ b/Documentation/admin-guide/laptops/samsung-galaxybook.rst
> @@ -0,0 +1,280 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +Samsung Galaxy Book Extras
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +December 15, 2024
> +
> +Joshua Grisham <josh@joshuagrisham.com>
> +
> +This is a Linux x86 platform driver for Samsung Galaxy Book series note=
book
> +devices which utilizes Samsung's ``SCAI`` ACPI device in order to contr=
ol
> +extra features and receive various notifications.
> +

Please only use a single empty lines in this doc.

> +
> +Supported devices
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Any device with one of the supported ACPI device IDs should be supporte=
d. This
> +covers most of the "Samsung Galaxy Book" series notebooks that are curr=
ently
> +available as of this writing, and could include other Samsung notebook =
devices
> +as well.
> +
> +
> +Status
> +=3D=3D=3D=3D=3D=3D
> +
> +The following features are currently supported:
> +
> +- :ref:`Keyboard backlight <keyboard-backlight>` control
> +- :ref:`Performance mode <performance-mode>` control implemented using =
the
> +  platform profile interface
> +- :ref:`Battery charge control end threshold
> +  <battery-charge-control-end-threshold>` (stop charging battery at giv=
en
> +  percentage value) implemented as a battery device extension
> +- :ref:`Settings Attributes <settings-attributes>` to allow control of =
various
> +  device settings
> +- :ref:`Handling of Fn hotkeys <keyboard-hotkey-actions>` for various a=
ctions
> +- :ref:`Tracepoint <tracepoint>` event for debugging ACPI device commun=
ication
> +
> +Because different models of these devices can vary in their features, t=
here is
> +logic built within the driver which attempts to test each implemented f=
eature
> +for a valid response before enabling its support (registering additiona=
l devices
> +or extensions, adding sysfs attributes, etc). Therefore, it can be impo=
rtant to
> +note that not all features may be supported for your particular device.
> +
> +The following features might be possible to implement but will require
> +additional investigation and are therefore not supported at this time:
> +
> +- "Dolby Atmos" mode for the speakers
> +- "Outdoor Mode" for increasing screen brightness on models with ``SAM0=
427``
> +- "Silent Mode" on models with ``SAM0427``
> +
> +
> +Parameters
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The driver includes a list of boolean parameters that allow for manuall=
y
> +enabling or disabling various features:
> +
> +- ``kbd_backlight``: Enable Keyboard Backlight control (default on)
> +- ``performance_mode``: Enable Performance Mode control (default on)
> +- ``battery_threshold``: Enable battery charge threshold control (defau=
lt on)
> +- ``allow_recording``: Enable control to allow or block access to camer=
a and
> +  microphone (default on)
> +- ``i8042_filter``: Enable capture and execution of keyboard-based hotk=
ey events
> +  (default on)
> +
> +.. note::
> +  Even if you explicitly try to enable a feature using its parameter, s=
upport
> +  for it will still be evaluated by the driver, and the feature will be
> +  disabled if it does not appear to be supported on your device.
> +
> +The availability of various sysfs file-based "settings" attributes
> +(``usb_charge``, ``start_on_lid_open``, etc) will be determined automat=
ically
> +and cannot be manually disabled at this time.
> +
> +
> +.. _keyboard-backlight:
> +
> +Keyboard backlight
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Controlled by parameter: ``kbd_backlight``
> +
> +A new LED class named ``samsung-galaxybook::kbd_backlight`` is created =
which
> +will then expose the device using the standard sysfs-based LED interfac=
e at
> +``/sys/class/leds/samsung-galaxybook::kbd_backlight``. Brightness can b=
e
> +controlled by writing values 0 to 3 to the ``brightness`` sysfs attribu=
te or
> +with any other desired userspace utility.
> +
> +.. note::
> +  Most of these devices have an ambient light sensor which also turns
> +  off the keyboard backlight under well-lit conditions. This behavior d=
oes not
> +  seem possible to control at this time, but can be good to be aware of=
.
> +
> +
> +.. _performance-mode:
> +
> +Performance mode
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Controlled by parameter: ``performance_mode``
> +
> +This driver implements the
> +Documentation/userspace-api/sysfs-platform_profile.rst interface for wo=
rking
> +with the "performance mode" function of the Samsung ACPI device.
> +
> +Mapping of each Samsung "performance mode" to its respective platform p=
rofile is
> +done dynamically based on a list of the supported modes reported by the=
 device
> +itself. Preference is given to always try and map ``low-power``, ``bala=
nced``,
> +and ``performance`` profiles, as these seem to be the most common profi=
les
> +utilized (and sometimes even required) by various userspace tools.
> +
> +The result of the mapping will be printed in the kernel log when the mo=
dule is
> +loaded. Supported profiles can also be retrieved from
> +``/sys/firmware/acpi/platform_profile_choices``, while
> +``/sys/firmware/acpi/platform_profile`` can be used to read or write th=
e
> +currently selected profile.
> +
> +The ``balanced`` platform profile will be set during module load if no =
profile
> +has been previously set.
> +
> +
> +.. _battery-charge-control-end-threshold:
> +
> +Battery charge control end threshold
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Controlled by parameter: ``battery_threshold``
> +
> +This platform driver will add the ability to set the battery's charge c=
ontrol
> +end threshold, but does not have the ability to set a start threshold.
> +
> +This feature is typically called "Battery Saver" by the various Samsung
> +applications in Windows, but in Linux we have implemented the standardi=
zed
> +"charge control threshold" sysfs interface on the battery device to all=
ow for
> +controlling this functionality from the userspace.
> +
> +The sysfs attribute
> +``/sys/class/power_supply/BAT1/charge_control_end_threshold`` can be us=
ed to
> +read or set the desired charge end threshold.
> +
> +If you wish to maintain interoperability with Windows, then you should =
set the
> +value to 80 to represent "on", or 0 to represent "off", as these are th=
e values
> +currently recognized by the various Windows-based Samsung applications =
and
> +services as "on" or "off". Otherwise, the device will accept any value =
between 0
> +(off) and 99 as the percentage that you wish the battery to stop chargi=
ng at.
> +
> +.. note::
> +  If you try to set a value of 100, the driver will also accept this in=
put, but
> +  will set the attribute value to 0 (i.e. 100% will "remove" the end th=
reshold).
> +
> +
> +.. _settings-attributes:
> +
> +Settings Attributes
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Various hardware settings can be controlled by the following sysfs attr=
ibutes:
> +
> +- ``allow_recording`` (allows or blocks usage of built-in camera and mi=
crophone)
> +- ``start_on_lid_open`` (power on automatically when opening the lid)
> +- ``usb_charge`` (allows USB ports to provide power even when device is=
 off)
> +
> +These attributes will be available under the path for your supported AC=
PI Device
> +ID's platform device (``SAM0428``, ``SAM0429``, etc), and can most reli=
ably
> +be found by seeing which device has been bound to the ``samsung-galaxyb=
ook``
> +driver. Here are some examples: ::
> +
> +  # find which device ID has been bound to the driver
> +  ls /sys/bus/platform/drivers/samsung-galaxybook/ | grep SAM
> +
> +  # see SAM0429 attributes
> +  ls /sys/bus/platform/drivers/samsung-galaxybook/SAM0429\:00
> +
> +  # see attributes no matter the device ID (using wildcard expansion)
> +  ls /sys/bus/platform/drivers/samsung-galaxybook/SAM*
> +
> +Most shells should support using wildcard expansion to directly read an=
d write
> +these attributes using the above pattern. Example: ::
> +
> +  # read value of start_on_lid_open
> +  cat /sys/bus/platform/drivers/samsung-galaxybook/SAM*/start_on_lid_op=
en
> +
> +  # turn on start_on_lid_open
> +  echo true | sudo tee /sys/bus/platform/drivers/samsung-galaxybook/SAM=
*/start_on_lid_open
> +
> +It is also possible to use a udev rule to create a fixed-path symlink t=
o your
> +device under ``/dev`` (e.g. ``/dev/samsung-galaxybook``), no matter the=
 device
> +ID, to further simplify reading and writing these attributes in the use=
rspace.
> +
> +Allow recording (allow_recording)
> +---------------------------------
> +
> +``/sys/bus/platform/drivers/samsung-galaxybook/SAM*/allow_recording``
> +
> +Controlled by parameter: ``allow_recording``
> +
> +Controls the "Allow recording" setting, which allows or blocks usage of=
 the
> +built-in camera and microphone (boolean).
> +
> +Start on lid open (start_on_lid_open)
> +-------------------------------------
> +
> +``/sys/bus/platform/drivers/samsung-galaxybook/SAM*/start_on_lid_open``
> +
> +Controls the "Start on lid open" setting, which sets the device to powe=
r on
> +automatically when the lid is opened (boolean).
> +
> +USB charge (usb_charge)
> +-----------------------
> +
> +``/sys/bus/platform/drivers/samsung-galaxybook/SAM*/usb_charge``
> +
> +Controls the "USB charge" setting, which allows USB ports to provide po=
wer even
> +when the device is turned off (boolean).
> +
> +.. note::
> +  For most devices, this setting seems to only apply to the USB-C ports=
.
> +
> +
> +.. _keyboard-hotkey-actions:
> +
> +Keyboard hotkey actions (i8042 filter)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Controlled by parameter: ``i8042_filter``
> +
> +The i8042 filter will swallow the keyboard events for the Fn+F9 hotkey =
(Multi-
> +level keyboard backlight toggle) and Fn+F10 hotkey (Allow/block recordi=
ng
> +toggle) and instead execute their actions within the driver itself.
> +
> +Fn+F9 will cycle through the brightness levels of the keyboard backligh=
t. A
> +notification will be sent using ``led_classdev_notify_brightness_hw_cha=
nged``
> +so that the userspace can be aware of the change. This mimics the behav=
ior of
> +other existing devices where the brightness level is cycled internally =
by the
> +embedded controller and then reported via a notification.
> +
> +Fn+F10 will toggle the value of the "Allow recording" setting.
> +
> +
> +ACPI notifications and ACPI hotkey actions
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +There is a new "Samsung Galaxy Book extra buttons" input device created=
 which
> +will send input events for the following notifications from the ACPI de=
vice:
> +
> +- Notification when the battery charge control end threshold has been r=
eached
> +  and the "battery saver" feature has stopped the battery from charging
> +- Notification when the device has been placed on a table (not availabl=
e on all
> +  models)
> +- Notification when the device has been lifted from a table (not availa=
ble on
> +  all models)
> +
> +The Fn+F11 Performance mode hotkey is received as an ACPI notification.=
 It will
> +be handled in a similar way as the Fn+F9 and Fn+F10 hotkeys; namely, th=
at the
> +keypress will be swallowed by the driver and each press will cycle to t=
he next
> +available platform profile.
> +
> +
> +.. _tracepoint:
> +
> +Tracepoint for debugging ACPI communication
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +A new tracepoint event ``samsung_galaxybook:samsung_galaxybook_acpi`` w=
ill
> +provide a trace of the buffers sent to, and received from, the ACPI dev=
ice
> +methods.
> +
> +Here is an example of how to use it: ::
> +
> +  # Enable tracepoint events
> +  echo 1 | sudo tee /sys/kernel/tracing/events/samsung_galaxybook/enabl=
e
> +
> +  # Perform some actions using the driver and then read the result
> +  sudo cat /sys/kernel/tracing/trace
> +
> +  # Disable tracepoint events when you are finished
> +  echo 0 | sudo tee /sys/kernel/tracing/events/samsung_galaxybook/enabl=
e
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3809931b9240..9e3b45cf799f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20733,6 +20733,14 @@ L:	linux-fbdev@vger.kernel.org
>   S:	Maintained
>   F:	drivers/video/fbdev/s3c-fb.c
>
> +SAMSUNG GALAXY BOOK EXTRAS DRIVER
> +M:	Joshua Grisham <josh@joshuagrisham.com>
> +L:	platform-driver-x86@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/admin-guide/laptops/samsung-galaxybook.rst
> +F:	drivers/platform/x86/samsung-galaxybook-trace.h
> +F:	drivers/platform/x86/samsung-galaxybook.c
> +
>   SAMSUNG INTERCONNECT DRIVERS
>   M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
>   M:	Artur =C5=9Awigo=C5=84 <a.swigon@samsung.com>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 0258dd879d64..03f4fb0e93e7 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -778,6 +778,24 @@ config BARCO_P50_GPIO
>   	  To compile this driver as a module, choose M here: the module
>   	  will be called barco-p50-gpio.
>
> +config SAMSUNG_GALAXYBOOK
> +	tristate "Samsung Galaxy Book extras driver"
> +	depends on ACPI
> +	depends on ACPI_BATTERY
> +	depends on INPUT
> +	depends on SERIO_I8042
> +	select ACPI_PLATFORM_PROFILE
> +	select INPUT_SPARSEKMAP
> +	select NEW_LEDS
> +	select LEDS_CLASS
> +	help
> +	  This is a driver for Samsung Galaxy Book series notebooks. It adds
> +	  support for the keyboard backlight control, performance mode control=
, fan
> +	  speed reporting, function keys, and various other device controls.
> +
> +	  For more information about this driver, see
> +	  <file:Documentation/admin-guide/laptops/samsung-galaxybook.rst>.
> +
>   config SAMSUNG_LAPTOP
>   	tristate "Samsung Laptop driver"
>   	depends on RFKILL || RFKILL =3D n
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefi=
le
> index e1b142947067..32ec4cb9d902 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -95,8 +95,9 @@ obj-$(CONFIG_PCENGINES_APU2)	+=3D pcengines-apuv2.o
>   obj-$(CONFIG_BARCO_P50_GPIO)	+=3D barco-p50-gpio.o
>
>   # Samsung
> -obj-$(CONFIG_SAMSUNG_LAPTOP)	+=3D samsung-laptop.o
> -obj-$(CONFIG_SAMSUNG_Q10)	+=3D samsung-q10.o
> +obj-$(CONFIG_SAMSUNG_GALAXYBOOK)	+=3D samsung-galaxybook.o
> +obj-$(CONFIG_SAMSUNG_LAPTOP)		+=3D samsung-laptop.o
> +obj-$(CONFIG_SAMSUNG_Q10)		+=3D samsung-q10.o
>
>   # Toshiba
>   obj-$(CONFIG_TOSHIBA_BT_RFKILL)	+=3D toshiba_bluetooth.o
> diff --git a/drivers/platform/x86/samsung-galaxybook-trace.h b/drivers/p=
latform/x86/samsung-galaxybook-trace.h
> new file mode 100644
> index 000000000000..09ab6dbe6586
> --- /dev/null
> +++ b/drivers/platform/x86/samsung-galaxybook-trace.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Samsung Galaxy Book series extras driver tracepoint events
> + *
> + * Copyright (c) 2024 Joshua Grisham <josh@joshuagrisham.com>
> + */
> +
> +#if !defined(_TRACE_SAMSUNG_GALAXYBOOK_H_) || defined(TRACE_HEADER_MULT=
I_READ)
> +#define _TRACE_SAMSUNG_GALAXYBOOK_H_
> +
> +#include <linux/types.h>
> +#include <linux/tracepoint.h>
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM samsung_galaxybook
> +
> +#define GALAXYBOOK_TRACE_MAX_ACPI_BUF_LENGTH 0x100
> +
> +TRACE_EVENT(samsung_galaxybook_acpi,
> +	TP_PROTO(const char *devname, const char *method, const char *label, u=
8 *buf, size_t len),
> +	TP_ARGS(devname, method, label, buf, len),
> +	TP_STRUCT__entry(
> +		__string(devname, devname)
> +		__string(method, method)
> +		__string(label, label)
> +		__array(u8, buf, GALAXYBOOK_TRACE_MAX_ACPI_BUF_LENGTH)
> +		__field(size_t, len)
> +	),
> +	TP_fast_assign(
> +		__assign_str(devname);
> +		__assign_str(method);
> +		__assign_str(label);
> +		memcpy(__entry->buf, buf, len);
> +		__entry->len =3D len;
> +	),
> +	TP_printk("device: %s, method: %s, %s: %s",
> +		  __get_str(devname),
> +		  __get_str(method),
> +		  __get_str(label),
> +		  __print_hex(__entry->buf, __entry->len))
> +);

I CCed the tracing guys so they can share their opinion on this.

> +
> +#endif
> +
> +#undef TRACE_INCLUDE_PATH
> +#undef TRACE_INCLUDE_FILE
> +
> +#define TRACE_INCLUDE_PATH ../../drivers/platform/x86
> +#define TRACE_INCLUDE_FILE samsung-galaxybook-trace
> +
> +#include <trace/define_trace.h>
> diff --git a/drivers/platform/x86/samsung-galaxybook.c b/drivers/platfor=
m/x86/samsung-galaxybook.c
> new file mode 100644
> index 000000000000..7baa3441fbfa
> --- /dev/null
> +++ b/drivers/platform/x86/samsung-galaxybook.c
> @@ -0,0 +1,1380 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Samsung Galaxy Book series extras driver
> + *
> + * Copyright (c) 2024 Joshua Grisham <josh@joshuagrisham.com>
> + *
> + * With contributions to the SCAI ACPI device interface:
> + * Copyright (c) 2024 Giulio Girardi <giulio.girardi@protechgroup.it>
> + *
> + * Implementation inspired by existing x86 platform drivers.
> + * Thank you to the authors!
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/err.h>
> +#include <linux/i8042.h>
> +#include <linux/init.h>
> +#include <linux/input.h>
> +#include <linux/input/sparse-keymap.h>
> +#include <linux/kernel.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/platform_profile.h>
> +#include <linux/serio.h>
> +#include <linux/sysfs.h>
> +#include <linux/uuid.h>
> +#include <linux/workqueue.h>
> +#include <acpi/battery.h>
> +
> +#define CREATE_TRACE_POINTS
> +#include "samsung-galaxybook-trace.h"
> +
> +#define DRIVER_NAME "samsung-galaxybook"
> +
> +/*
> + * Module parameters
> + */
> +
> +static bool kbd_backlight =3D true;
> +static bool battery_threshold =3D true;
> +static bool performance_mode =3D true;
> +static bool allow_recording =3D true;
> +static bool i8042_filter =3D true;
> +
> +module_param(kbd_backlight, bool, 0);
> +MODULE_PARM_DESC(kbd_backlight, "Enable Keyboard Backlight control (def=
ault on)");
> +module_param(battery_threshold, bool, 0);
> +MODULE_PARM_DESC(battery_threshold, "Enable battery charge threshold co=
ntrol (default on)");
> +module_param(performance_mode, bool, 0);
> +MODULE_PARM_DESC(performance_mode, "Enable Performance Mode control (de=
fault on)");
> +module_param(allow_recording, bool, 0);
> +MODULE_PARM_DESC(allow_recording,
> +		 "Enable control to allow or block access to camera and microphone (d=
efault on)");
> +module_param(i8042_filter, bool, 0);
> +MODULE_PARM_DESC(i8042_filter, "Enable capturing keyboard hotkey events=
 (default on)");
> +
> +/*
> + * Device definitions and matching
> + */
> +
> +static const struct acpi_device_id galaxybook_device_ids[] =3D {
> +	{ "SAM0427" },
> +	{ "SAM0428" },
> +	{ "SAM0429" },
> +	{ "SAM0430" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(acpi, galaxybook_device_ids);
> +
> +struct samsung_galaxybook {
> +	struct platform_device *platform;
> +	struct acpi_device *acpi;
> +	struct mutex acpi_lock;
> +
> +	struct led_classdev kbd_backlight;
> +
> +	struct input_dev *input;
> +	struct mutex input_lock;
> +
> +	void *i8042_filter_ptr;
> +	struct work_struct kbd_backlight_hotkey_work;
> +	struct work_struct allow_recording_hotkey_work;
> +
> +	struct acpi_battery_hook battery_hook;
> +	struct device_attribute charge_control_end_threshold_attr;
> +
> +	u8 *profile_performance_modes;
> +	struct platform_profile_handler profile_handler;
> +};
> +static struct samsung_galaxybook *galaxybook_ptr;
> +
> +struct sawb {
> +	u16 safn;
> +	u16 sasb;
> +	u8 rflg;
> +	union {
> +		struct {
> +			u8 gunm;
> +			u8 guds[250];
> +		};
> +		struct {
> +			u8 caid[16];
> +			u8 fncn;
> +			u8 subn;
> +			u8 iob0;
> +			u8 iob1;
> +			u8 iob2;
> +			u8 iob3;
> +			u8 iob4;
> +			u8 iob5;
> +			u8 iob6;
> +			u8 iob7;
> +			u8 iob8;
> +			u8 iob9;
> +		};
> +		struct {
> +			u8 iob_prefix[18];
> +			u8 iob_values[10];
> +		};
> +	};
> +};
> +
> +#define SAWB_LEN_SETTINGS         0x15
> +#define SAWB_LEN_PERFORMANCE_MODE 0x100
> +
> +#define SAFN  0x5843
> +
> +#define SASB_KBD_BACKLIGHT     0x78
> +#define SASB_POWER_MANAGEMENT  0x7a
> +#define SASB_USB_CHARGE_GET    0x67
> +#define SASB_USB_CHARGE_SET    0x68
> +#define SASB_NOTIFICATIONS     0x86
> +#define SASB_ALLOW_RECORDING   0x8a
> +#define SASB_PERFORMANCE_MODE  0x91
> +
> +#define SAWB_RFLG_POS  4
> +#define SAWB_GUNM_POS  5
> +
> +#define RFLG_SUCCESS  0xaa
> +#define GUNM_FAIL     0xff
> +
> +#define GUNM_FEATURE_ENABLE          0xbb
> +#define GUNM_FEATURE_ENABLE_SUCCESS  0xdd
> +#define GUDS_FEATURE_ENABLE          0xaa
> +#define GUDS_FEATURE_ENABLE_SUCCESS  0xcc
> +
> +#define GUNM_GET  0x81
> +#define GUNM_SET  0x82
> +
> +#define GUNM_POWER_MANAGEMENT  0x82
> +
> +#define GUNM_USB_CHARGE_GET              0x80
> +#define GUNM_USB_CHARGE_ON               0x81
> +#define GUNM_USB_CHARGE_OFF              0x80
> +#define GUDS_START_ON_LID_OPEN           0xa3
> +#define GUDS_START_ON_LID_OPEN_GET       0x81
> +#define GUDS_START_ON_LID_OPEN_SET       0x80
> +#define GUDS_BATTERY_CHARGE_CONTROL      0xe9
> +#define GUDS_BATTERY_CHARGE_CONTROL_GET  0x91
> +#define GUDS_BATTERY_CHARGE_CONTROL_SET  0x90
> +#define GUNM_ACPI_NOTIFY_ENABLE          0x80
> +#define GUDS_ACPI_NOTIFY_ENABLE          0x02
> +
> +#define FNCN_PERFORMANCE_MODE       0x51
> +#define SUBN_PERFORMANCE_MODE_LIST  0x01
> +#define SUBN_PERFORMANCE_MODE_GET   0x02
> +#define SUBN_PERFORMANCE_MODE_SET   0x03
> +
> +/* guid 8246028d-8bca-4a55-ba0f-6f1e6b921b8f */
> +static const guid_t performance_mode_guid_value =3D
> +	GUID_INIT(0x8246028d, 0x8bca, 0x4a55, 0xba, 0x0f, 0x6f, 0x1e, 0x6b, 0x=
92, 0x1b, 0x8f);
> +#define PERFORMANCE_MODE_GUID performance_mode_guid_value
> +
> +#define PERFORMANCE_MODE_ULTRA               0x16
> +#define PERFORMANCE_MODE_PERFORMANCE         0x15
> +#define PERFORMANCE_MODE_SILENT              0xb
> +#define PERFORMANCE_MODE_QUIET               0xa
> +#define PERFORMANCE_MODE_OPTIMIZED           0x2
> +#define PERFORMANCE_MODE_PERFORMANCE_LEGACY  0x1
> +#define PERFORMANCE_MODE_OPTIMIZED_LEGACY    0x0
> +#define PERFORMANCE_MODE_UNKNOWN             0xff
> +
> +#define DEFAULT_PLATFORM_PROFILE PLATFORM_PROFILE_BALANCED
> +
> +#define ACPI_METHOD_ENABLE           "SDLS"
> +#define ACPI_METHOD_ENABLE_ON        1
> +#define ACPI_METHOD_ENABLE_OFF       0
> +#define ACPI_METHOD_SETTINGS         "CSFI"
> +#define ACPI_METHOD_PERFORMANCE_MODE "CSXI"
> +
> +#define KBD_BACKLIGHT_MAX_BRIGHTNESS  3
> +
> +#define ACPI_NOTIFY_BATTERY_STATE_CHANGED    0x61
> +#define ACPI_NOTIFY_DEVICE_ON_TABLE          0x6c
> +#define ACPI_NOTIFY_DEVICE_OFF_TABLE         0x6d
> +#define ACPI_NOTIFY_HOTKEY_PERFORMANCE_MODE  0x70
> +
> +#define GB_KEY_KBD_BACKLIGHT_KEYDOWN    0x2c
> +#define GB_KEY_KBD_BACKLIGHT_KEYUP      0xac
> +#define GB_KEY_ALLOW_RECORDING_KEYDOWN  0x1f
> +#define GB_KEY_ALLOW_RECORDING_KEYUP    0x9f
> +
> +static const struct key_entry galaxybook_acpi_keymap[] =3D {
> +	{ KE_KEY, ACPI_NOTIFY_BATTERY_STATE_CHANGED,   { KEY_BATTERY } },
> +	{ KE_KEY, ACPI_NOTIFY_DEVICE_ON_TABLE,         { KEY_F14 } },
> +	{ KE_KEY, ACPI_NOTIFY_DEVICE_OFF_TABLE,        { KEY_F15 } },
> +	{ KE_KEY, ACPI_NOTIFY_HOTKEY_PERFORMANCE_MODE, { KEY_UNKNOWN } },
> +	{ KE_END, 0 },
> +};
> +
> +/*
> + * ACPI method handling
> + */
> +
> +static int galaxybook_acpi_method(struct samsung_galaxybook *galaxybook=
, acpi_string method,
> +				  struct sawb *in_buf, size_t len, const char *purpose_str,
> +				  struct sawb *out_buf)
> +{
> +	struct acpi_buffer output =3D {ACPI_ALLOCATE_BUFFER, NULL};
> +	union acpi_object in_obj, *out_obj;
> +	struct acpi_object_list input;
> +	acpi_status status;
> +	int err;
> +
> +	mutex_lock(&galaxybook->acpi_lock);

I do not think that providing locking around each ACPI method call is nece=
ssary, the AML code will
do this itself if necessary.

> +
> +	in_obj.type =3D ACPI_TYPE_BUFFER;
> +	in_obj.buffer.length =3D len;
> +	in_obj.buffer.pointer =3D (u8 *)in_buf;
> +
> +	input.count =3D 1;
> +	input.pointer =3D &in_obj;
> +
> +	trace_samsung_galaxybook_acpi(dev_name(&galaxybook->acpi->dev), method=
, purpose_str,
> +				      in_obj.buffer.pointer, in_obj.buffer.length);
> +
> +	status =3D acpi_evaluate_object_typed(galaxybook->acpi->handle, method=
, &input, &output,
> +					    ACPI_TYPE_BUFFER);
> +
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(&galaxybook->acpi->dev, "failed %s with ACPI method %s; got %=
s\n",
> +			purpose_str, method, acpi_format_exception(status));
> +		err =3D -ENXIO;

-EIO please.

> +		goto out_free;

out_obj is not assigned here so this would cause problems. Please just ret=
urn directly.

> +	}
> +
> +	out_obj =3D output.pointer;
> +
> +	trace_samsung_galaxybook_acpi(dev_name(&galaxybook->acpi->dev), method=
, "response",
> +				      out_obj->buffer.pointer, out_obj->buffer.length);
> +
> +	if (out_obj->buffer.length !=3D len || out_obj->buffer.length < SAWB_G=
UNM_POS + 1) {
> +		dev_err(&galaxybook->acpi->dev, "failed %s with ACPI method %s; "
> +		       "response length mismatch\n",
> +		       purpose_str, method);
> +		err =3D -ETOOSMALL;

-EPROTO please.

> +		goto out_free;
> +	}
> +	if (out_obj->buffer.pointer[SAWB_RFLG_POS] !=3D RFLG_SUCCESS) {
> +		dev_err(&galaxybook->acpi->dev, "failed %s with ACPI method %s; "
> +		       "device did not respond with success code 0x%x\n",
> +		       purpose_str, method, RFLG_SUCCESS);
> +		err =3D -EIO;

-ENXIO please.

> +		goto out_free;
> +	}
> +	if (out_obj->buffer.pointer[SAWB_GUNM_POS] =3D=3D GUNM_FAIL) {
> +		dev_err(&galaxybook->acpi->dev,
> +			"failed %s with ACPI method %s; device responded with failure code 0=
x%x\n",
> +		       purpose_str, method, GUNM_FAIL);
> +		err =3D -EIO;

-ENXIO please.

> +		goto out_free;
> +	}
> +
> +	memcpy(out_buf, out_obj->buffer.pointer, len);
> +	err =3D 0;
> +
> +out_free:
> +	kfree(out_obj);
> +	mutex_unlock(&galaxybook->acpi_lock);
> +	return err;
> +}
> +
> +static int galaxybook_enable_acpi_feature(struct samsung_galaxybook *ga=
laxybook, const u16 sasb)
> +{
> +	struct sawb buf =3D { 0 };
> +	int err;
> +
> +	buf.safn =3D SAFN;
> +	buf.sasb =3D sasb;
> +	buf.gunm =3D GUNM_FEATURE_ENABLE;
> +	buf.guds[0] =3D GUDS_FEATURE_ENABLE;
> +
> +	err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf,=
 SAWB_LEN_SETTINGS,
> +				     "enabling ACPI feature", &buf);
> +	if (err)
> +		return err;
> +
> +	if (buf.gunm !=3D GUNM_FEATURE_ENABLE_SUCCESS && buf.guds[0] !=3D GUDS=
_FEATURE_ENABLE_SUCCESS)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +/*
> + * Keyboard Backlight
> + */
> +
> +static int kbd_backlight_acpi_set(struct samsung_galaxybook *galaxybook=
,
> +				  const enum led_brightness brightness)
> +{
> +	struct sawb buf =3D { 0 };
> +	int err;
> +
> +	buf.safn =3D SAFN;
> +	buf.sasb =3D SASB_KBD_BACKLIGHT;
> +	buf.gunm =3D GUNM_SET;
> +
> +	buf.guds[0] =3D brightness;
> +
> +	err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf,=
 SAWB_LEN_SETTINGS,
> +				     "setting kbd_backlight brightness", &buf);
> +	if (err)
> +		return err;
> +
> +	galaxybook->kbd_backlight.brightness =3D brightness;

This variable is handled by the LED class code, please do not access it.

> +
> +	return 0;
> +}
> +
> +static int kbd_backlight_acpi_get(struct samsung_galaxybook *galaxybook=
,
> +				  enum led_brightness *brightness)
> +{
> +	struct sawb buf =3D { 0 };
> +	int err;
> +
> +	buf.safn =3D SAFN;
> +	buf.sasb =3D SASB_KBD_BACKLIGHT;
> +	buf.gunm =3D GUNM_GET;
> +
> +	err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf,=
 SAWB_LEN_SETTINGS,
> +				     "getting kbd_backlight brightness", &buf);
> +	if (err)
> +		return err;
> +
> +	*brightness =3D buf.gunm;
> +	galaxybook->kbd_backlight.brightness =3D buf.gunm;

Same as above.

> +
> +	return 0;
> +}
> +
> +static int kbd_backlight_store(struct led_classdev *led,
> +			       const enum led_brightness brightness)
> +{
> +	struct samsung_galaxybook *galaxybook =3D
> +		container_of(led, struct samsung_galaxybook, kbd_backlight);
> +
> +	return kbd_backlight_acpi_set(galaxybook, brightness);
> +}
> +
> +static enum led_brightness kbd_backlight_show(struct led_classdev *led)
> +{
> +	struct samsung_galaxybook *galaxybook =3D
> +		container_of(led, struct samsung_galaxybook, kbd_backlight);
> +	enum led_brightness brightness;
> +	int err;
> +
> +	err =3D kbd_backlight_acpi_get(galaxybook, &brightness);
> +	if (err)
> +		return err;
> +
> +	return brightness;
> +}
> +
> +static int galaxybook_kbd_backlight_init(struct samsung_galaxybook *gal=
axybook)
> +{
> +	struct led_init_data init_data =3D {};
> +	enum led_brightness brightness;
> +	int err;
> +
> +	err =3D galaxybook_enable_acpi_feature(galaxybook, SASB_KBD_BACKLIGHT)=
;
> +	if (err)
> +		return err;
> +
> +	/* verify we can read the value, otherwise init should stop and fail *=
/
> +	err =3D kbd_backlight_acpi_get(galaxybook, &brightness);
> +	if (err)
> +		return err;
> +
> +	init_data.devicename =3D DRIVER_NAME;
> +	init_data.default_label =3D ":" LED_FUNCTION_KBD_BACKLIGHT;
> +	init_data.devname_mandatory =3D true;
> +
> +	galaxybook->kbd_backlight.brightness_get =3D kbd_backlight_show;
> +	galaxybook->kbd_backlight.brightness_set_blocking =3D kbd_backlight_st=
ore;
> +	galaxybook->kbd_backlight.flags =3D LED_BRIGHT_HW_CHANGED;
> +	galaxybook->kbd_backlight.max_brightness =3D KBD_BACKLIGHT_MAX_BRIGHTN=
ESS;
> +
> +	return devm_led_classdev_register_ext(&galaxybook->platform->dev,
> +					      &galaxybook->kbd_backlight, &init_data);
> +}
> +
> +/*
> + * Platform device attributes (configuration properties which can be co=
ntrolled via userspace)
> + */
> +
> +/* Start on lid open (device should power on when lid is opened) */
> +
> +static int start_on_lid_open_acpi_set(struct samsung_galaxybook *galaxy=
book, const bool value)
> +{
> +	struct sawb buf =3D { 0 };
> +
> +	buf.safn =3D SAFN;
> +	buf.sasb =3D SASB_POWER_MANAGEMENT;
> +	buf.gunm =3D GUNM_POWER_MANAGEMENT;
> +	buf.guds[0] =3D GUDS_START_ON_LID_OPEN;
> +	buf.guds[1] =3D GUDS_START_ON_LID_OPEN_SET;
> +	buf.guds[2] =3D value ? 1 : 0;
> +
> +	return galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf, =
SAWB_LEN_SETTINGS,
> +				      "setting start_on_lid_open", &buf);
> +}
> +
> +static int start_on_lid_open_acpi_get(struct samsung_galaxybook *galaxy=
book, bool *value)
> +{
> +	struct sawb buf =3D { 0 };
> +	int err;
> +
> +	buf.safn =3D SAFN;
> +	buf.sasb =3D SASB_POWER_MANAGEMENT;
> +	buf.gunm =3D GUNM_POWER_MANAGEMENT;
> +	buf.guds[0] =3D GUDS_START_ON_LID_OPEN;
> +	buf.guds[1] =3D GUDS_START_ON_LID_OPEN_GET;
> +
> +	err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf,=
 SAWB_LEN_SETTINGS,
> +				     "getting start_on_lid_open", &buf);
> +	if (err)
> +		return err;
> +
> +	*value =3D buf.guds[1];
> +
> +	return 0;
> +}
> +
> +static ssize_t start_on_lid_open_store(struct device *dev, struct devic=
e_attribute *attr,
> +				       const char *buffer, size_t count)
> +{
> +	struct samsung_galaxybook *galaxybook =3D dev_get_drvdata(dev);
> +	bool value;
> +	int err;
> +
> +	if (!count)
> +		return -EINVAL;
> +
> +	err =3D kstrtobool(buffer, &value);
> +	if (err)
> +		return err;
> +
> +	err =3D start_on_lid_open_acpi_set(galaxybook, value);
> +	if (err)
> +		return err;
> +
> +	return count;
> +}
> +
> +static ssize_t start_on_lid_open_show(struct device *dev, struct device=
_attribute *attr,
> +				      char *buffer)
> +{
> +	struct samsung_galaxybook *galaxybook =3D dev_get_drvdata(dev);
> +	bool value;
> +	int err;
> +
> +	err =3D start_on_lid_open_acpi_get(galaxybook, &value);
> +	if (err)
> +		return err;
> +
> +	return sysfs_emit(buffer, "%u\n", value);
> +}
> +
> +static DEVICE_ATTR_RW(start_on_lid_open);
> +
> +/* USB Charge (USB ports can charge other devices even when device is p=
owered off) */
> +
> +static int usb_charge_acpi_set(struct samsung_galaxybook *galaxybook, c=
onst bool value)
> +{
> +	struct sawb buf =3D { 0 };
> +
> +	buf.safn =3D SAFN;
> +	buf.sasb =3D SASB_USB_CHARGE_SET;
> +	buf.gunm =3D value ? GUNM_USB_CHARGE_ON : GUNM_USB_CHARGE_OFF;
> +
> +	return galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf, =
SAWB_LEN_SETTINGS,
> +				      "setting usb_charge", &buf);
> +}
> +
> +static int usb_charge_acpi_get(struct samsung_galaxybook *galaxybook, b=
ool *value)
> +{
> +	struct sawb buf =3D { 0 };
> +	int err;
> +
> +	buf.safn =3D SAFN;
> +	buf.sasb =3D SASB_USB_CHARGE_GET;
> +	buf.gunm =3D GUNM_USB_CHARGE_GET;
> +
> +	err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf,=
 SAWB_LEN_SETTINGS,
> +				     "getting usb_charge", &buf);
> +	if (err)
> +		return err;
> +
> +	*value =3D buf.gunm;
> +
> +	return 0;
> +}
> +
> +static ssize_t usb_charge_store(struct device *dev, struct device_attri=
bute *attr,
> +				const char *buffer, size_t count)
> +{
> +	struct samsung_galaxybook *galaxybook =3D dev_get_drvdata(dev);
> +	bool value;
> +	int err;
> +
> +	if (!count)
> +		return -EINVAL;
> +
> +	err =3D kstrtobool(buffer, &value);
> +	if (err)
> +		return err;
> +
> +	err =3D usb_charge_acpi_set(galaxybook, value);
> +	if (err)
> +		return err;
> +
> +	return count;
> +}
> +
> +static ssize_t usb_charge_show(struct device *dev, struct device_attrib=
ute *attr, char *buffer)
> +{
> +	struct samsung_galaxybook *galaxybook =3D dev_get_drvdata(dev);
> +	bool value;
> +	int err;
> +
> +	err =3D usb_charge_acpi_get(galaxybook, &value);
> +	if (err)
> +		return err;
> +
> +	return sysfs_emit(buffer, "%u\n", value);
> +}
> +
> +static DEVICE_ATTR_RW(usb_charge);
> +
> +/* Allow recording (allows or blocks access to camera and microphone) *=
/
> +
> +static int allow_recording_acpi_set(struct samsung_galaxybook *galaxybo=
ok, const bool value)
> +{
> +	struct sawb buf =3D { 0 };
> +
> +	buf.safn =3D SAFN;
> +	buf.sasb =3D SASB_ALLOW_RECORDING;
> +	buf.gunm =3D GUNM_SET;
> +	buf.guds[0] =3D value ? 1 : 0;
> +
> +	return galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf, =
SAWB_LEN_SETTINGS,
> +				      "setting allow_recording", &buf);
> +}
> +
> +static int allow_recording_acpi_get(struct samsung_galaxybook *galaxybo=
ok, bool *value)
> +{
> +	struct sawb buf =3D { 0 };
> +	int err;
> +
> +	buf.safn =3D SAFN;
> +	buf.sasb =3D SASB_ALLOW_RECORDING;
> +	buf.gunm =3D GUNM_GET;
> +
> +	err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf,=
 SAWB_LEN_SETTINGS,
> +				     "getting allow_recording", &buf);
> +	if (err)
> +		return err;
> +
> +	*value =3D buf.gunm =3D=3D 1;
> +
> +	return 0;
> +}
> +
> +static ssize_t allow_recording_store(struct device *dev, struct device_=
attribute *attr,
> +				     const char *buffer, size_t count)
> +{
> +	struct samsung_galaxybook *galaxybook =3D dev_get_drvdata(dev);
> +	bool value;
> +	int err;
> +
> +	if (!count)
> +		return -EINVAL;
> +
> +	err =3D kstrtobool(buffer, &value);
> +	if (err)
> +		return err;
> +
> +	err =3D allow_recording_acpi_set(galaxybook, value);
> +	if (err)
> +		return err;
> +
> +	return count;
> +}
> +
> +static ssize_t allow_recording_show(struct device *dev, struct device_a=
ttribute *attr, char *buffer)
> +{
> +	struct samsung_galaxybook *galaxybook =3D dev_get_drvdata(dev);
> +	bool value;
> +	int err;
> +
> +	err =3D allow_recording_acpi_get(galaxybook, &value);
> +	if (err)
> +		return err;
> +
> +	return sysfs_emit(buffer, "%u\n", value);
> +}
> +
> +static DEVICE_ATTR_RW(allow_recording);
> +
> +static umode_t galaxybook_attr_is_visible(struct kobject *kobj, struct =
attribute *attr, int idx)
> +{
> +	struct device *dev =3D kobj_to_dev(kobj);
> +	struct samsung_galaxybook *galaxybook =3D dev_get_drvdata(dev);
> +	bool value;
> +	int err;
> +
> +	if (attr =3D=3D &dev_attr_start_on_lid_open.attr) {
> +		err =3D start_on_lid_open_acpi_get(galaxybook, &value);
> +		return err ? 0 : attr->mode;
> +	}
> +
> +	if (attr =3D=3D &dev_attr_usb_charge.attr) {
> +		err =3D usb_charge_acpi_get(galaxybook, &value);
> +		return err ? 0 : attr->mode;
> +	}
> +
> +	if (attr =3D=3D &dev_attr_allow_recording.attr) {
> +		if (!allow_recording)
> +			return 0;
> +		err =3D galaxybook_enable_acpi_feature(galaxybook, SASB_ALLOW_RECORDI=
NG);
> +		if (err) {
> +			dev_dbg(&galaxybook->platform->dev,
> +				"failed to initialize ACPI allow_recording feature\n");
> +			allow_recording =3D false;
> +			return 0;
> +		}
> +		err =3D allow_recording_acpi_get(galaxybook, &value);
> +		if (err) {
> +			allow_recording =3D false;
> +			return 0;
> +		}
> +		return attr->mode;
> +	}
> +
> +	return attr->mode;
> +}
> +
> +static struct attribute *galaxybook_attrs[] =3D {
> +	&dev_attr_start_on_lid_open.attr,
> +	&dev_attr_usb_charge.attr,
> +	&dev_attr_allow_recording.attr,
> +};

Needs to be NULL-terminated.

> +
> +static const struct attribute_group galaxybook_attrs_group =3D {
> +	.attrs =3D galaxybook_attrs,
> +	.is_visible =3D galaxybook_attr_is_visible,
> +};

AFAIK this can safely be added to the drivers .dev_groups. The driver core=
 will ensure that
those sysfs attrs are registers after the drivers .probe callback returned=
 successfully.

> +
> +/*
> + * Battery Extension (adds charge_control_end_threshold to the battery =
device)
> + */
> +
> +static int charge_control_end_threshold_acpi_set(struct samsung_galaxyb=
ook *galaxybook, u8 value)
> +{
> +	struct sawb buf =3D { 0 };
> +
> +	if (value > 100)
> +		return -EINVAL;
> +	/* if setting to 100, should be set to 0 (no threshold) */
> +	if (value =3D=3D 100)
> +		value =3D 0;

Please also handle the case here value is zero. You can for example return=
 -EINVAL in this case.

> +
> +	buf.safn =3D SAFN;
> +	buf.sasb =3D SASB_POWER_MANAGEMENT;
> +	buf.gunm =3D GUNM_POWER_MANAGEMENT;
> +	buf.guds[0] =3D GUDS_BATTERY_CHARGE_CONTROL;
> +	buf.guds[1] =3D GUDS_BATTERY_CHARGE_CONTROL_SET;
> +	buf.guds[2] =3D value;
> +
> +	return galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf, =
SAWB_LEN_SETTINGS,
> +				      "setting battery charge_control_end_threshold", &buf);
> +}
> +
> +static int charge_control_end_threshold_acpi_get(struct samsung_galaxyb=
ook *galaxybook, u8 *value)
> +{
> +	struct sawb buf =3D { 0 };
> +	int err;
> +
> +	buf.safn =3D SAFN;
> +	buf.sasb =3D SASB_POWER_MANAGEMENT;
> +	buf.gunm =3D GUNM_POWER_MANAGEMENT;
> +	buf.guds[0] =3D GUDS_BATTERY_CHARGE_CONTROL;
> +	buf.guds[1] =3D GUDS_BATTERY_CHARGE_CONTROL_GET;
> +
> +	err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf,=
 SAWB_LEN_SETTINGS,
> +				     "getting battery charge_control_end_threshold", &buf);
> +	if (err)
> +		return err;
> +
> +	*value =3D buf.guds[1];
> +
> +	return 0;
> +}
> +
> +static ssize_t charge_control_end_threshold_store(struct device *dev, s=
truct device_attribute *attr,
> +						  const char *buffer, size_t count)
> +{
> +	struct samsung_galaxybook *galaxybook =3D
> +		container_of(attr, struct samsung_galaxybook, charge_control_end_thre=
shold_attr);
> +	u8 value;
> +	int err;
> +
> +	if (!count)
> +		return -EINVAL;
> +
> +	err =3D kstrtou8(buffer, 0, &value);
> +	if (err)
> +		return err;
> +
> +	err =3D charge_control_end_threshold_acpi_set(galaxybook, value);
> +	if (err)
> +		return err;
> +
> +	return count;
> +}
> +
> +static ssize_t charge_control_end_threshold_show(struct device *dev, st=
ruct device_attribute *attr,
> +						 char *buffer)
> +{
> +	struct samsung_galaxybook *galaxybook =3D
> +		container_of(attr, struct samsung_galaxybook, charge_control_end_thre=
shold_attr);
> +	u8 value;
> +	int err;
> +
> +	err =3D charge_control_end_threshold_acpi_get(galaxybook, &value);
> +	if (err)
> +		return err;
> +
> +	return sysfs_emit(buffer, "%d\n", value);
> +}
> +
> +static int galaxybook_battery_add(struct power_supply *battery, struct =
acpi_battery_hook *hook)
> +{
> +	struct samsung_galaxybook *galaxybook =3D
> +		container_of(hook, struct samsung_galaxybook, battery_hook);
> +
> +	return device_create_file(&battery->dev, &galaxybook->charge_control_e=
nd_threshold_attr);
> +}
> +
> +static int galaxybook_battery_remove(struct power_supply *battery, stru=
ct acpi_battery_hook *hook)
> +{
> +	struct samsung_galaxybook *galaxybook =3D
> +		container_of(hook, struct samsung_galaxybook, battery_hook);
> +
> +	device_remove_file(&battery->dev, &galaxybook->charge_control_end_thre=
shold_attr);
> +	return 0;
> +}
> +
> +static int galaxybook_battery_threshold_init(struct samsung_galaxybook =
*galaxybook)
> +{
> +	struct acpi_battery_hook *hook;
> +	struct device_attribute *attr;
> +	u8 value;
> +	int err;
> +
> +	err =3D charge_control_end_threshold_acpi_get(galaxybook, &value);
> +	if (err)
> +		return err;
> +
> +	hook =3D &galaxybook->battery_hook;
> +	hook->add_battery =3D galaxybook_battery_add;
> +	hook->remove_battery =3D galaxybook_battery_remove;
> +	hook->name =3D "Samsung Galaxy Book Battery Extension";
> +
> +	attr =3D &galaxybook->charge_control_end_threshold_attr;
> +	sysfs_attr_init(attr->attr);
> +	attr->attr.name =3D "charge_control_end_threshold";
> +	attr->attr.mode =3D 0644;
> +	attr->show =3D charge_control_end_threshold_show;
> +	attr->store =3D charge_control_end_threshold_store;
> +
> +	return devm_battery_hook_register(&galaxybook->platform->dev, &galaxyb=
ook->battery_hook);
> +}
> +
> +/*
> + * Platform Profile / Performance mode
> + */
> +
> +static int performance_mode_acpi_set(struct samsung_galaxybook *galaxyb=
ook,
> +				     const u8 performance_mode)
> +{
> +	struct sawb buf =3D { 0 };
> +
> +	buf.safn =3D SAFN;
> +	buf.sasb =3D SASB_PERFORMANCE_MODE;
> +	export_guid(buf.caid, &PERFORMANCE_MODE_GUID);
> +	buf.fncn =3D FNCN_PERFORMANCE_MODE;
> +	buf.subn =3D SUBN_PERFORMANCE_MODE_SET;
> +	buf.iob0 =3D performance_mode;
> +
> +	return galaxybook_acpi_method(galaxybook, ACPI_METHOD_PERFORMANCE_MODE=
, &buf,
> +				      SAWB_LEN_PERFORMANCE_MODE, "setting performance_mode", &buf);
> +}
> +
> +static int performance_mode_acpi_get(struct samsung_galaxybook *galaxyb=
ook, u8 *performance_mode)
> +{
> +	struct sawb buf =3D { 0 };
> +	int err;
> +
> +	buf.safn =3D SAFN;
> +	buf.sasb =3D SASB_PERFORMANCE_MODE;
> +	export_guid(buf.caid, &PERFORMANCE_MODE_GUID);
> +	buf.fncn =3D FNCN_PERFORMANCE_MODE;
> +	buf.subn =3D SUBN_PERFORMANCE_MODE_GET;
> +
> +	err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_PERFORMANCE_MOD=
E, &buf,
> +				     SAWB_LEN_PERFORMANCE_MODE, "getting performance_mode", &buf);
> +	if (err)
> +		return err;
> +
> +	*performance_mode =3D buf.iob0;
> +
> +	return 0;
> +}
> +
> +static int get_performance_mode_profile(struct samsung_galaxybook *gala=
xybook,
> +					const u8 performance_mode,
> +					enum platform_profile_option *profile)
> +{
> +	for (int i =3D 0; i < PLATFORM_PROFILE_LAST; i++) {
> +		if (galaxybook->profile_performance_modes[i] =3D=3D performance_mode)=
 {
> +			if (profile)
> +				*profile =3D i;
> +			return 0;
> +		}
> +	}
> +
> +	return -ENODATA;
> +}
> +
> +static int galaxybook_platform_profile_set(struct platform_profile_hand=
ler *pprof,
> +					   enum platform_profile_option profile)
> +{
> +	struct samsung_galaxybook *galaxybook =3D
> +		container_of(pprof, struct samsung_galaxybook, profile_handler);
> +
> +	return performance_mode_acpi_set(galaxybook,
> +					 galaxybook->profile_performance_modes[profile]);
> +}
> +
> +static int galaxybook_platform_profile_get(struct platform_profile_hand=
ler *pprof,
> +					   enum platform_profile_option *profile)
> +{
> +	struct samsung_galaxybook *galaxybook =3D
> +		container_of(pprof, struct samsung_galaxybook, profile_handler);
> +	u8 performance_mode;
> +	int err;
> +
> +	err =3D performance_mode_acpi_get(galaxybook, &performance_mode);
> +	if (err)
> +		return err;
> +
> +	return get_performance_mode_profile(galaxybook, performance_mode, prof=
ile);
> +}
> +
> +static void galaxybook_profile_exit(void *data)
> +{
> +	struct samsung_galaxybook *galaxybook =3D data;
> +
> +	platform_profile_remove(&galaxybook->profile_handler);
> +}
> +
> +#define IGNORE_PERFORMANCE_MODE_MAPPING  -1
> +
> +static int galaxybook_profile_init(struct samsung_galaxybook *galaxyboo=
k)
> +{
> +	u8 current_performance_mode;
> +	struct sawb buf =3D { 0 };
> +	int mapped_profiles;
> +	int mode_profile;
> +	int err;
> +	int i;
> +
> +	galaxybook->profile_handler.profile_get =3D galaxybook_platform_profil=
e_get;
> +	galaxybook->profile_handler.profile_set =3D galaxybook_platform_profil=
e_set;
> +
> +	/* fetch supported performance mode values from ACPI method */
> +	buf.safn =3D SAFN;
> +	buf.sasb =3D SASB_PERFORMANCE_MODE;
> +	export_guid(buf.caid, &PERFORMANCE_MODE_GUID);
> +	buf.fncn =3D FNCN_PERFORMANCE_MODE;
> +	buf.subn =3D SUBN_PERFORMANCE_MODE_LIST;
> +
> +	err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_PERFORMANCE_MOD=
E,
> +				     &buf, SAWB_LEN_PERFORMANCE_MODE,
> +				     "get supported performance modes", &buf);
> +	if (err)
> +		return err;
> +
> +	/* set up profile_performance_modes with "unknown" as init value */
> +	galaxybook->profile_performance_modes =3D
> +		kcalloc(PLATFORM_PROFILE_LAST, sizeof(u8), GFP_KERNEL);
> +	if (!galaxybook->profile_performance_modes)
> +		return -ENOMEM;
> +	for (i =3D 0; i < PLATFORM_PROFILE_LAST; i++)
> +		galaxybook->profile_performance_modes[i] =3D PERFORMANCE_MODE_UNKNOWN=
;
> +
> +	/*
> +	 * Value returned in iob0 will have the number of supported performanc=
e modes.
> +	 * The performance mode values will then be given as a list after this=
 (iob1-iobX).
> +	 * Loop backwards from last value to first value (to handle fallback c=
ases which come with
> +	 * smaller values) and map each supported value to its correct platfor=
m_profile_option.
> +	 */
> +	for (i =3D buf.iob0; i > 0; i--) {
> +		/*
> +		 * Prefer mapping to at least performance, balanced, and low-power pr=
ofiles, as they
> +		 * are the profiles which are typically supported by userspace tools
> +		 * (power-profiles-daemon, etc).
> +		 * - performance =3D "ultra", otherwise "performance"
> +		 * - balanced    =3D "optimized", otherwise "performance" when "ultra=
" is supported
> +		 * - low-power   =3D "silent", otherwise "quiet"
> +		 * Different models support different modes. Additional supported mod=
es will be
> +		 * mapped to profiles that fall in between these 3.
> +		 */
> +		switch (buf.iob_values[i]) {
> +
> +		case PERFORMANCE_MODE_ULTRA:
> +			/* ultra always maps to performance */
> +			mode_profile =3D PLATFORM_PROFILE_PERFORMANCE;
> +			break;
> +
> +		case PERFORMANCE_MODE_PERFORMANCE:
> +			/* if ultra exists, map performance to balanced-performance */
> +			if (galaxybook->profile_performance_modes[PLATFORM_PROFILE_PERFORMAN=
CE] !=3D
> +			    PERFORMANCE_MODE_UNKNOWN)
> +				mode_profile =3D PLATFORM_PROFILE_BALANCED_PERFORMANCE;
> +			else /* otherwise map it to performance instead */
> +				mode_profile =3D PLATFORM_PROFILE_PERFORMANCE;
> +			break;
> +
> +		case PERFORMANCE_MODE_SILENT:
> +			/* silent always maps to low-power */
> +			mode_profile =3D PLATFORM_PROFILE_LOW_POWER;
> +			break;
> +
> +		case PERFORMANCE_MODE_QUIET:
> +			/* if silent exists, map quiet to quiet */
> +			if (galaxybook->profile_performance_modes[PLATFORM_PROFILE_LOW_POWER=
] !=3D
> +			    PERFORMANCE_MODE_UNKNOWN)
> +				mode_profile =3D PLATFORM_PROFILE_QUIET;
> +			else /* otherwise map it to low-power for better userspace tool supp=
ort */
> +				mode_profile =3D PLATFORM_PROFILE_LOW_POWER;
> +			break;
> +
> +		case PERFORMANCE_MODE_OPTIMIZED:
> +			/* optimized always maps to balanced */
> +			mode_profile =3D PLATFORM_PROFILE_BALANCED;
> +			break;
> +
> +		case PERFORMANCE_MODE_PERFORMANCE_LEGACY:
> +			/* map to performance if performance is not already supported */
> +			if (galaxybook->profile_performance_modes[PLATFORM_PROFILE_PERFORMAN=
CE] =3D=3D
> +			    PERFORMANCE_MODE_UNKNOWN)
> +				mode_profile =3D PLATFORM_PROFILE_PERFORMANCE;
> +			else /* otherwise, ignore */
> +				mode_profile =3D IGNORE_PERFORMANCE_MODE_MAPPING;
> +			break;
> +
> +		case PERFORMANCE_MODE_OPTIMIZED_LEGACY:
> +			/* map to balanced if balanced is not already supported */
> +			if (galaxybook->profile_performance_modes[PLATFORM_PROFILE_BALANCED]=
 =3D=3D
> +			    PERFORMANCE_MODE_UNKNOWN)
> +				mode_profile =3D PLATFORM_PROFILE_BALANCED;
> +			else /* otherwise, ignore */
> +				mode_profile =3D IGNORE_PERFORMANCE_MODE_MAPPING;
> +			break;
> +
> +		default: /* any other value is not supported */
> +			mode_profile =3D IGNORE_PERFORMANCE_MODE_MAPPING;
> +			break;
> +		}
> +
> +		/* if current mode value mapped to a supported platform_profile_optio=
n, set it up */
> +		if (mode_profile !=3D IGNORE_PERFORMANCE_MODE_MAPPING) {
> +			mapped_profiles++;
> +			galaxybook->profile_performance_modes[mode_profile] =3D buf.iob_valu=
es[i];
> +			set_bit(mode_profile, galaxybook->profile_handler.choices);
> +			dev_dbg(&galaxybook->platform->dev,
> +				"will support platform profile %d (performance mode 0x%x)\n",
> +				mode_profile, buf.iob_values[i]);
> +		} else {
> +			dev_dbg(&galaxybook->platform->dev,
> +				"unmapped performance mode 0x%x will be ignored\n",
> +				buf.iob_values[i]);
> +		}
> +	}
> +
> +	if (mapped_profiles =3D=3D 0)
> +		return -ENODEV;
> +
> +	err =3D platform_profile_register(&galaxybook->profile_handler);

Please update the code to conform to the updated platform profile API.

> +	if (err)
> +		return err;
> +
> +	/* now check currently set performance mode; if not supported then set=
 default profile */
> +	err =3D performance_mode_acpi_get(galaxybook, &current_performance_mod=
e);
> +	if (err)
> +		goto err_remove_exit;
> +	err =3D get_performance_mode_profile(galaxybook, current_performance_m=
ode, NULL);
> +	if (err) {
> +		dev_dbg(&galaxybook->platform->dev,
> +			"initial performance mode value is not supported by device; "
> +			"setting to default\n");
> +		err =3D galaxybook_platform_profile_set(&galaxybook->profile_handler,
> +						      DEFAULT_PLATFORM_PROFILE);
> +		if (err)
> +			goto err_remove_exit;
> +	}
> +
> +	/* if adding dev remove action fails, remove now and return failure */
> +	err =3D devm_add_action_or_reset(&galaxybook->platform->dev,
> +				       galaxybook_profile_exit, galaxybook);
> +	if (err)
> +		goto err_remove_exit;
> +
> +	return 0;
> +
> +err_remove_exit:
> +	galaxybook_profile_exit(galaxybook);
> +	return err;

The error handling is a bit strange.

Please try to set the default platform profile first before registering th=
e platform profile interface,
then register the platform profile interface and use devm_add_action_or_re=
set().

> +}
> +
> +/*
> + * Hotkey work and filters
> + */
> +
> +static void galaxybook_kbd_backlight_hotkey_work(struct work_struct *wo=
rk)
> +{
> +	struct samsung_galaxybook *galaxybook =3D
> +		container_of(work, struct samsung_galaxybook, kbd_backlight_hotkey_wo=
rk);
> +
> +	if (galaxybook->kbd_backlight.brightness < galaxybook->kbd_backlight.m=
ax_brightness)
> +		kbd_backlight_acpi_set(galaxybook, galaxybook->kbd_backlight.brightne=
ss + 1);
> +	else
> +		kbd_backlight_acpi_set(galaxybook, 0);
> +
> +	led_classdev_notify_brightness_hw_changed(
> +		&galaxybook->kbd_backlight,
> +		galaxybook->kbd_backlight.brightness);

This is the exact reason why i think this should be done in userspace. You=
 can replace this code
with a simple input event submission using the KBDILLUM* key codes. This w=
ould also allow you to
avoid any special locking in this case.

This would also allow userspace to configure the step with of the brightne=
ss changes.

> +}
> +
> +static void galaxybook_allow_recording_hotkey_work(struct work_struct *=
work)
> +{
> +	struct samsung_galaxybook *galaxybook =3D
> +		container_of(work, struct samsung_galaxybook, allow_recording_hotkey_=
work);
> +	bool value;
> +
> +	allow_recording_acpi_get(galaxybook, &value);
> +	allow_recording_acpi_set(galaxybook, !value);

Please add some locking here, the value of "allow recording" might have be=
en changed by another
thread in the mid of those two function calls.

> +}
> +
> +static bool galaxybook_i8042_filter(unsigned char data, unsigned char s=
tr, struct serio *port)
> +{
> +	static bool extended;
> +
> +	if (str & I8042_STR_AUXDATA)
> +		return false;
> +
> +	if (unlikely(data =3D=3D 0xe0)) {
> +		extended =3D true;
> +		return true;
> +	} else if (unlikely(extended)) {
> +		extended =3D false;
> +		switch (data) {
> +
> +		case GB_KEY_KBD_BACKLIGHT_KEYDOWN:
> +			return true;
> +		case GB_KEY_KBD_BACKLIGHT_KEYUP:
> +			if (kbd_backlight)
> +				schedule_work(&galaxybook_ptr->kbd_backlight_hotkey_work);
> +			return true;
> +
> +		case GB_KEY_ALLOW_RECORDING_KEYDOWN:
> +			return true;
> +		case GB_KEY_ALLOW_RECORDING_KEYUP:
> +			if (allow_recording)
> +				schedule_work(&galaxybook_ptr->allow_recording_hotkey_work);
> +			return true;
> +
> +		default:
> +			/*
> +			 * Report the previously filtered e0 before continuing
> +			 * with the next non-filtered byte.
> +			 */
> +			serio_interrupt(port, 0xe0, 0);
> +			return false;
> +		}
> +	}
> +
> +	return false;
> +}
> +
> +static void galaxybook_i8042_filter_remove(void *data)
> +{
> +	struct samsung_galaxybook *galaxybook =3D data;
> +
> +	i8042_remove_filter(galaxybook_i8042_filter);
> +	cancel_work_sync(&galaxybook->kbd_backlight_hotkey_work);
> +	cancel_work_sync(&galaxybook->allow_recording_hotkey_work);
> +}
> +
> +static int galaxybook_i8042_filter_install(struct samsung_galaxybook *g=
alaxybook)
> +{
> +	int err;
> +
> +	/* initialize hotkey work queues */
> +	if (kbd_backlight)
> +		INIT_WORK(&galaxybook->kbd_backlight_hotkey_work,
> +			  galaxybook_kbd_backlight_hotkey_work);
> +	if (allow_recording)
> +		INIT_WORK(&galaxybook->allow_recording_hotkey_work,
> +			  galaxybook_allow_recording_hotkey_work);
> +
> +	err =3D i8042_install_filter(galaxybook_i8042_filter);
> +	if (err) {
> +		cancel_work_sync(&galaxybook->kbd_backlight_hotkey_work);
> +		cancel_work_sync(&galaxybook->allow_recording_hotkey_work);
> +		return err;
> +	}

No work should be active should i8042_install_filter fail.

> +
> +	/* if adding dev remove action fails, remove now and return failure */
> +	err =3D devm_add_action_or_reset(&galaxybook->platform->dev,
> +				       galaxybook_i8042_filter_remove, galaxybook);
> +	if (err) {
> +		galaxybook_i8042_filter_remove(galaxybook);

This will be called automatically be devm_add_action_or_reset().

> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Input device (hotkeys and notifications)
> + */
> +
> +static void galaxybook_input_notify(struct samsung_galaxybook *galaxybo=
ok, int event)
> +{
> +	if (!galaxybook->input)
> +		return;
> +	mutex_lock(&galaxybook->input_lock);
> +	if (!sparse_keymap_report_event(galaxybook->input, event, 1, true))
> +		dev_warn(&galaxybook->acpi->dev, "unknown input notification event: 0=
x%x\n", event);
> +	mutex_unlock(&galaxybook->input_lock);
> +}
> +
> +static int galaxybook_input_init(struct samsung_galaxybook *galaxybook)
> +{
> +	int err;
> +
> +	galaxybook->input =3D devm_input_allocate_device(&galaxybook->platform=
->dev);
> +	if (!galaxybook->input)
> +		return -ENOMEM;
> +
> +	galaxybook->input->name =3D "Samsung Galaxy Book Extra Buttons";
> +	galaxybook->input->phys =3D DRIVER_NAME "/input0";
> +	galaxybook->input->id.bustype =3D BUS_HOST;
> +	galaxybook->input->dev.parent =3D &galaxybook->platform->dev;
> +
> +	err =3D sparse_keymap_setup(galaxybook->input, galaxybook_acpi_keymap,=
 NULL);
> +	if (err)
> +		return err;
> +
> +	return input_register_device(galaxybook->input);
> +}
> +
> +/*
> + * ACPI device setup
> + */
> +
> +static void galaxybook_acpi_notify(acpi_handle handle, u32 event, void =
*data)
> +{
> +	struct samsung_galaxybook *galaxybook =3D data;
> +
> +	if (event =3D=3D ACPI_NOTIFY_HOTKEY_PERFORMANCE_MODE) {
> +		if (performance_mode) {
> +			platform_profile_cycle();
> +			goto exit;
> +		}
> +	}
> +
> +	galaxybook_input_notify(galaxybook, event);
> +
> +exit:
> +	acpi_bus_generate_netlink_event(DRIVER_NAME, dev_name(&galaxybook->pla=
tform->dev),
> +					event, 0);
> +}
> +
> +static int galaxybook_enable_acpi_notify(struct samsung_galaxybook *gal=
axybook)
> +{
> +	struct sawb buf =3D { 0 };
> +	int err;
> +
> +	err =3D galaxybook_enable_acpi_feature(galaxybook, SASB_NOTIFICATIONS)=
;
> +	if (err)
> +		return err;
> +
> +	buf.safn =3D SAFN;
> +	buf.sasb =3D SASB_NOTIFICATIONS;
> +	buf.gunm =3D GUNM_ACPI_NOTIFY_ENABLE;
> +	buf.guds[0] =3D GUDS_ACPI_NOTIFY_ENABLE;
> +
> +	return galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf, =
SAWB_LEN_SETTINGS,
> +				      "activate ACPI notifications", &buf);
> +}
> +
> +static void galaxybook_acpi_remove_notify_handler(void *data)
> +{
> +	struct samsung_galaxybook *galaxybook =3D data;
> +
> +	acpi_remove_notify_handler(galaxybook->acpi->handle, ACPI_ALL_NOTIFY,
> +				   galaxybook_acpi_notify);
> +}
> +
> +static void galaxybook_acpi_disable(void *data)
> +{
> +	struct samsung_galaxybook *galaxybook =3D data;
> +
> +	acpi_execute_simple_method(galaxybook->acpi->handle,
> +				   ACPI_METHOD_ENABLE, ACPI_METHOD_ENABLE_OFF);
> +}
> +
> +static int galaxybook_acpi_init(struct samsung_galaxybook *galaxybook)
> +{
> +	acpi_status status;
> +	int err;
> +
> +	status =3D acpi_execute_simple_method(galaxybook->acpi->handle, ACPI_M=
ETHOD_ENABLE,
> +					    ACPI_METHOD_ENABLE_ON);
> +	if (ACPI_FAILURE(status))
> +		return -ENXIO;

-EIO please.

> +	err =3D devm_add_action_or_reset(&galaxybook->platform->dev,
> +				       galaxybook_acpi_disable, galaxybook);
> +	if (err)
> +		return err;
> +
> +	status =3D acpi_install_notify_handler(galaxybook->acpi->handle, ACPI_=
ALL_NOTIFY,
> +					     galaxybook_acpi_notify, galaxybook);
> +	if (ACPI_FAILURE(status))
> +		return -ENXIO;

Same as above.

> +	err =3D devm_add_action_or_reset(&galaxybook->platform->dev,
> +				       galaxybook_acpi_remove_notify_handler, galaxybook);
> +	if (err)
> +		return err;
> +
> +	err =3D galaxybook_enable_acpi_notify(galaxybook);
> +	if (err) {
> +		dev_warn(&galaxybook->platform->dev, "failed to enable ACPI notificat=
ions; "
> +			 "some hotkeys will not be supported\n");
> +	} else {
> +		err =3D galaxybook_input_init(galaxybook);
> +		if (err)
> +			dev_warn(&galaxybook->platform->dev,
> +				 "failed to initialize input device\n");

You should initialize the input device before registering the i8042 filter=
 and the ACPI notify handler,
or else they might try to submit input events on a allocated but not-yet-r=
egistered input device.

Also please call galaxybook_enable_acpi_notify() after registering the inp=
ut device.

> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Platform driver
> + */
> +
> +#define galaxybook_init_feature(module_param, init_func)			\
> +do {										\
> +	if (module_param) {							\
> +		err =3D init_func(galaxybook);					\
> +		if (err) {							\
> +			dev_dbg(&galaxybook->platform->dev,			\
> +				"failed to initialize " #module_param "\n");	\
> +			module_param =3D false;					\
> +		}								\
> +	}									\
> +} while (0)

See checkpatch for complains about this. Also i would prefer if you drop t=
his macro.

> +
> +static int galaxybook_probe(struct platform_device *pdev)
> +{
> +	struct acpi_device *adev =3D ACPI_COMPANION(&pdev->dev);
> +	struct samsung_galaxybook *galaxybook;
> +	int err;
> +
> +	if (!adev)
> +		return -ENODEV;
> +
> +	dev_dbg(&pdev->dev, "loading driver\n");
> +
> +	galaxybook =3D devm_kzalloc(&pdev->dev, sizeof(*galaxybook), GFP_KERNE=
L);
> +	if (!galaxybook)
> +		return -ENOMEM;
> +	/* set static pointer here so it can be used in i8042 filter */
> +	galaxybook_ptr =3D galaxybook;

Please check if this pointer is already set and return -EBUSY in such a ca=
se.

> +
> +	galaxybook->platform =3D pdev;
> +	galaxybook->acpi =3D adev;

You can also just store pdev->dev and the ACPI handle here.

> +
> +	dev_set_drvdata(&galaxybook->platform->dev, galaxybook);
> +	devm_mutex_init(&galaxybook->platform->dev, &galaxybook->acpi_lock);
> +	devm_mutex_init(&galaxybook->platform->dev, &galaxybook->input_lock);

Missing error handling here.

> +
> +	err =3D galaxybook_acpi_init(galaxybook);
> +	if (err) {
> +		dev_err(&galaxybook->acpi->dev, "failed to initialize the ACPI device=
\n");
> +		return err;
> +	}
> +
> +	err =3D galaxybook_enable_acpi_feature(galaxybook, SASB_POWER_MANAGEME=
NT);
> +	if (err) {
> +		dev_warn(&galaxybook->acpi->dev,
> +			 "failed to initialize ACPI power management features; "
> +			 "many features of this driver will not be available\n");
> +		performance_mode =3D false;
> +		battery_threshold =3D false;
> +	}
> +
> +	galaxybook_init_feature(performance_mode, galaxybook_profile_init);
> +	galaxybook_init_feature(battery_threshold, galaxybook_battery_threshol=
d_init);
> +
> +	/* add attrs group here as the is_visible requires above initializatio=
ns */
> +	err =3D devm_device_add_group(&galaxybook->platform->dev, &galaxybook_=
attrs_group);
> +	if (err)
> +		dev_warn(&galaxybook->platform->dev, "failed to add platform device a=
ttributes\n");

When using .dev_groups the driver core will registers those after the prob=
e callback returns, so please
use .dev_groups.

> +
> +	galaxybook_init_feature(kbd_backlight, galaxybook_kbd_backlight_init);
> +
> +	/* i8042_filter should be disabled if kbd_backlight and allow_recordin=
g are disabled */
> +	if (!kbd_backlight && !allow_recording)
> +		i8042_filter =3D false;
> +
> +	galaxybook_init_feature(i8042_filter, galaxybook_i8042_filter_install)=
;

Does installing the i8042 filter involve any IO? If no then please fail pr=
obing if an error
occurs here.

I think with would make sense to do this printing inside the initializatio=
n functions. They can also
return 0 instead of an error when they determine that the feature is simpl=
y not available on a given machine
so that all real errors can be treated as such and result in an probe fail=
ure.

I think the dell-wmi-ddv driver does something similar.

> +
> +	dev_dbg(&galaxybook->platform->dev, "driver successfully loaded\n");
> +
> +	return 0;
> +}
> +
> +static void galaxybook_remove(struct platform_device *pdev)
> +{
> +	struct samsung_galaxybook *galaxybook =3D dev_get_drvdata(&pdev->dev);
> +
> +	if (galaxybook_ptr)
> +		galaxybook_ptr =3D NULL;
> +
> +	dev_dbg(&galaxybook->platform->dev, "driver removed\n");

Maybe you should also use devres for this, since this will only get called=
 if the previous
probe callback was successful.

In general i am very positive about this driver. Nearly all issues are rat=
her small, so i am
looking forward to the v4 patch series :).

Thanks,
Armin Wolf

> +}
> +
> +static struct platform_driver galaxybook_platform_driver =3D {
> +	.driver =3D {
> +		.name =3D DRIVER_NAME,
> +		.acpi_match_table =3D galaxybook_device_ids,
> +	},
> +	.probe =3D galaxybook_probe,
> +	.remove =3D galaxybook_remove,
> +};
> +module_platform_driver(galaxybook_platform_driver);
> +
> +MODULE_AUTHOR("Joshua Grisham <josh@joshuagrisham.com>");
> +MODULE_DESCRIPTION("Samsung Galaxy Book Extras");
> +MODULE_LICENSE("GPL");
