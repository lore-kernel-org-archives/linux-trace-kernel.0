Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FEA3597C;
	Wed, 18 Dec 2024 18:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734547070; cv=none; b=eUvQj4ZsCnK3AeT7xYMfo3McoVmHHfceUeUK+HjDRP6uWk+2QIIXX9vT/chVaXYkq+puehwRN7HJKWOPXsyqTo3CGicWPcy3NzsS2ohI0lyuoDO1FXbvR4HWQkSeO0FcMFHCZJiWfW+Kya9rCMGJCy23XSO+0cROszrEuSk0BUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734547070; c=relaxed/simple;
	bh=LREft+AACPcc3Ll7HjmrtCDuO6HfgzalMF/6ktsYEY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hMqmeUmURCuSOlC9xMG14r97RAKDPOY/Qh1FLhZJtyhJ9Uf2x07xQ/ecqwCuooNHs3+SKNRNoXH6JK7x4Hy4raw6yN6B+ydBu2UkmptaYHeZWItXRlO5n1sVFpoc8k6GO+fQD9FcnixMnkUllhnyp7xb9majTWlqUMjD8gHXl1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=mJLhs+Bn; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="mJLhs+Bn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1734547037; x=1735151837; i=w_armin@gmx.de;
	bh=LREft+AACPcc3Ll7HjmrtCDuO6HfgzalMF/6ktsYEY0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mJLhs+BnyRff1b+m0uNv05YnD6riryW9vk5SY3i1snT6G62oNQOW8lVWaGBEiBXw
	 xv/O4lZxwkLSTK2/XbUR0JnSz5KPWaE3p6hhuEBzYVB4/RmyzqwpnYaaC9Da/g4BQ
	 n7Bq1Ztgj61RTAIrt/muzPFIGqTFM9Sz0DI79t9FDGeSsmteGGahbH70QLh6MXD/O
	 gvMw2KN3IDLlDhEoae/h5l8mZQhS3/YMzmR/93Jni+MBNFOvoqPLRYj3jn3299xEn
	 we+R3iHm699qAYQCZph6QOACVl+TMHo45H8RItcnnHeGOmZOXXPEg4M0zr7tMwxc4
	 InuUdTnk/CjCzClKMQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([91.14.230.110]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MatVh-1tyhRm2E9r-00bZSH; Wed, 18
 Dec 2024 19:37:17 +0100
Message-ID: <a0fd8c4a-598a-4fec-a8c9-c1435f880f7a@gmx.de>
Date: Wed, 18 Dec 2024 19:37:10 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] platform/x86: samsung-galaxybook: Add
 samsung-galaxybook driver
To: Hans de Goede <hdegoede@redhat.com>,
 Joshua Grisham <josh@joshuagrisham.com>, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, corbet@lwn.net,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org
References: <20241216103855.18457-1-josh@joshuagrisham.com>
 <c23c4c88-786a-4662-a448-deb006b7a03c@gmx.de>
 <6d2e175f-0a84-4a6f-9484-c2c299bcc3c5@redhat.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <6d2e175f-0a84-4a6f-9484-c2c299bcc3c5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eBgquaRcXWM93wLmKkO2143eWvW+bkMvcApl7Nsat0fUWz5IuJ+
 KiXlpDFm8nkx01F4n531nUsm1rWu9APsn5a99gN34M7eZGMUBGFza4NeGu9Wa/L+r40xpsb
 zhNfH2qrBoVOIacwdlbVojES3rX4jpErWOPKki3GO1ruNfbYKYQ1L9BIExONegDs9l0GvN0
 za2UAImtA81IUVXyaSJGQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YxJa90v0py4=;7Xy6v1B2B2O4BUg+ma2ahxvvPtJ
 GEpT7mYiFxdl8uiYMytGpebQW2E1oOspgYALV9/w3JsFyNUNwYIFxEcYNnyvWPHc35v8atzrt
 f2zn0C/BMy59hDUptcnc4z+bVqayvSZYn1oqlrgtxiVVcDB+8fdAg8RAW5CGdibwfunvJ2pqi
 qTSYX1muq2TX0PKqx9td41GGZ0cB4BMhm1VsAifFOJeyl49pepuTs/srWzYXNDJ2pyCK58+tu
 Hg2VeNu/TesHFDx4dvax5Otgkip9MmDau9dTdSY5MtJQSq2CnZKUQ8F+VWeuvsopPuItgCbY/
 viUJzHd14THSv8/VKo5c6HyinAxprdhdxTtKj53g4FgtLHZ/s0lxZY1p6bFMCdNFQLmoMyBjV
 2HnxTjjSpgD2nPZE4TGzH5MG37hqZN3Ln/JvOiHHnpDg+7/Q6sPXw9ukkKIf/88GQXCPfOmcx
 wfe8KKCe78f2mRoA7GcpvIuqOTWjjedagCAuDx+zSHJxlE6ogEG7fNq625QOX705w11p2h1x4
 91ZcqvxrDPm+vGzVpuPyEAKQ1zeCVLU53uSZP+sv4w6UaowUaAG8p0IedCRzMnCrz4YsvAKRU
 Kh3uUhj2OK13VioWkOBvhiSaCROrXf7yEL0NctGcOOS8PXk9HjBPOnO4o5pbfwPZI2bBc+i8c
 PLDY0ouohoyuXYq852b1F9q+7t+op9KF2etgd5ZafhmZGBlLwmQ8KBfZ0JPgWp5JDzyjuZDSI
 02ROfcQtsL6riI9Vsqk7N9D3hc0JxXVL+IJHe0lQRrQYlyX09pf0SHhZDS5u5d9cjmu/NQEFF
 SPbj4mGLOY/vC0MfnGWFvD2pwcTuz24PKOSMGdRrZtNwDufJcAjEVYzG8Zktv6jFtgvm6eNyh
 JMN1aZkdcW/axzh+7HgmNvjeWwPER0hhoairjQQcXnWQkP8qkVNKCvegs43zJKL8b8BG0yVaF
 d7kBcD10wItFY4L3TRkHaQl1P+WmMKL4lQoNli64S7/weuQgFHikBZLyAc56TLhzPQ320oj8d
 vQOMT06qgkhjaVFExVyMA0lV4KJRAFO8CoFFx5NJPyHfyy5/+O4SRWVzn6Rx3Yeeo3J3xpsQk
 qO/sIify38aAivT+mGBpjJEHDvAWZu

Am 18.12.24 um 15:24 schrieb Hans de Goede:

> Hi Armin,
>
> Thank you for reviewing this new driver.
>
> On 17-Dec-24 10:31 PM, Armin Wolf wrote:
>> Am 16.12.24 um 11:38 schrieb Joshua Grisham:
> <snip>
>
>>> +/*
>>> + * Hotkey work and filters
>>> + */
>>> +
>>> +static void galaxybook_kbd_backlight_hotkey_work(struct work_struct *=
work)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct samsung_galaxybook *galaxybook =3D
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 container_of(work, struct =
samsung_galaxybook, kbd_backlight_hotkey_work);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (galaxybook->kbd_backlight.brightness < galaxyb=
ook->kbd_backlight.max_brightness)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kbd_backlight_acpi_set(gal=
axybook, galaxybook->kbd_backlight.brightness + 1);
>>> +=C2=A0=C2=A0=C2=A0 else
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kbd_backlight_acpi_set(gal=
axybook, 0);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 led_classdev_notify_brightness_hw_changed(
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &galaxybook->kbd_backlight=
,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 galaxybook->kbd_backlight.=
brightness);
>> This is the exact reason why i think this should be done in userspace. =
You can replace this code
>> with a simple input event submission using the KBDILLUM* key codes. Thi=
s would also allow you to
>> avoid any special locking in this case.
>>
>> This would also allow userspace to configure the step with of the brigh=
tness changes.
> As discussed in an earlier thread, there is really no good way to let
> userspace handle this atm. KEY_KBDILLUMTOGGLE gets mapped to XF86KbdLigh=
tOnOff
> while we really want Cycle, as we have in e.g. XF86MonBrightnessCycle.
>
> I just checked gnome-settings-daemon and it does handle XF86KbdLightOnOf=
f
> but it only toggles on/off. In most laptops the cycle key is handled by
> the embedded controller and this simply emulates that common setup to
> match what userspace currently expects.
>
> Handling this in userspace would require adding a new KEY_KBDILLUMCYCLE
> and then adding support for that to xkb and maybe also upower and
> gnome-settings-daemon and KDE and then wait for that all to land before
> things start to work.
>
> As for your argument about allowing to set the percentage to step,
> note that this in kernel handling only increaeses the level by 1 on
> the hotkey press that make sense because typically these kbds backlights
> only have 2 - 4 levels.
>
> So IMHO handling this in the kernel is an acceptable compromise,
> (yes I do realize that this is a compromise).
>
> If some need arises later to do move this to userspace we can always
> add a module parameter to completely disable the in kernel handling and
> instead send out a new KEY_KBDILLUMCYCLE key-code when this now
> module parameter is set.
>
> Regards,
>
> Hans

I see, in this case we can indeed handle this inside the kernel.

However we should really use led_set_brightness_sync() here instead of man=
ually updating the brightness.
Also we need a mutex here so that the whole read-modify-write brightness u=
pdate is atomic.

Thanks,
Armin Wolf

