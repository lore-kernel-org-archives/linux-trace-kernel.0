Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FF31BEF68
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Dec 2024 14:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734531859; cv=none; b=ZRpJQ9+HypHXerL0dfBgeANdu979oo7v73jxQS78n0HpqdV2H69tzImFVvpZsRdYoWshyt15Lh9bNWi/9BH0RQP8YGdeuOJAv4qXIrZrriiQzqUUIriUxQ6JoHg2C76V2LkEMrFKxJ86fY7fFblrhosNmXoBxHr0HeTPgE0krKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734531859; c=relaxed/simple;
	bh=fxq5WPhXvFyAK+buBZe3FD3w5xOl2nrTCisD3TZj8AA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HShbcehljcozRXCils8OyjgjyDlQDGkUmKD3z90Qrg00iOr69oEHcw2u/DeM6sldswbSQEssMMB3Ty+AQIh+EEwTxqya50RIgAfRRBTWOgZvFhozR6ehdONeFAVRel7uJIKDylGXtvEZ7RTtbu9hDZz0K8Q9i1fKYsDXmo/5/YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U0HTxed+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0HTxed+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734531857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wYDfdm4rHVwC2HrRooT1qxFxAJepkEO0lOVD/zIJr0U=;
	b=U0HTxed+WSF9L1T/KL3v3LZdMsCOxTZTa3wBWyqBXA8TWQwUo+XHDQVEwCTiPnPx5T6o64
	g6y7RoXExisv/j4qZ2vK2a3PinX7+MTU4ZMWK2Sep2uw3T/WYp2m148Dnv8SPTd4utu/Ci
	ZJhVvngvoIgvYv1F05mSY4E/1jOV398=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-ux3glI4BO7CUhXr284-PPg-1; Wed, 18 Dec 2024 09:24:13 -0500
X-MC-Unique: ux3glI4BO7CUhXr284-PPg-1
X-Mimecast-MFC-AGG-ID: ux3glI4BO7CUhXr284-PPg
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5d3d9d6293fso3949496a12.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Dec 2024 06:24:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734531853; x=1735136653;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wYDfdm4rHVwC2HrRooT1qxFxAJepkEO0lOVD/zIJr0U=;
        b=IsCsUmQbuqpsU6GwZkywDSBirolhrb7bWgPvFz3bVQi0DJEMTeQRXoJID8ly9vUOMX
         6lr8vHWG8RI2+KmpBupT4fpzOYJm/q2CZgLN7cytyO2ovBVVK/DykFmhXRb7np3fJ4jW
         5kqOEbvyHktxcdxBLk+DfVjJMv+rWyXu7ObOSSGwzsBQTkAKFavNJFx9G14CsDVgapkc
         FlOfpW33+GbguoFyyJSdmeE4sbq4uZ18EZrbZsYu+j6623FXEQxqJzAynmUrrcUaJ1FP
         vgkRe/db4cC+Q7soAQeHY5RIKzSFY6JqpkfBQ4I6DdEu+aP7sDW4Cs4e/c2AQCfDZHPA
         br2A==
X-Forwarded-Encrypted: i=1; AJvYcCVw+7Da4eHq/4Nkv2nFXA0cOmFWggQKo7oCMwD5/GP6Bdb0zGRfC1VyaV6bAxYRLSFbddRY/ZKhLLuJuvnN2qEBl+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyemIbhhqp9yXtM5iabb37yaeuW4RtaH3CfItPeEjtf6vM/Bmsq
	tPIybTqIBYTWAju9gJnbUiexFan2+yDukJpvLsPSlwp+3HdpVgLlkaodXeiA9CRr7buVT7qundj
	hr0P2NumdHYyrb5IwIP+GSRif50nA5JmdrgZkISBGenaRLBxOjkTGVU+X1szwoqvK3SxiVA==
X-Gm-Gg: ASbGncumAtyXacYr7gCY4JhvjUphICRYAZp3RATV2wD8VYGo8vTlhwLcVSax/5hByeN
	XM/QrqtnMJhfo4eRRb28VcjCMpXvzGhKpEq8gDCxcRzrJ7ofQ5qmQvkEISYXCywSInGl4P5aVHj
	7FkTRf6prbRATqxeu/laxM5jS7FYBWh17LZP4+B1X3fLyxkWIy03tzgZ87nuWDxUbG38LF/Cw7X
	8r6w/6JBh3TIUwxh21adVeHyV/rXibAvYjC0ZpZc9XxM+Z6rE2ymfj/6FBfMz4WHQyc005CLbQh
	L1Ok+IQQuqIzCahTQBKC/iHZDDV4vQ02/iMtbuZuINtlhVItD6dy273VsetlO8/SHuVsytfUN0z
	9LbkEwmNGMb4wtZo5NUdJwxUym5OXy3Q=
X-Received: by 2002:a05:6402:34cb:b0:5d0:e826:f0da with SMTP id 4fb4d7f45d1cf-5d7ee3b4ce0mr2712543a12.16.1734531852727;
        Wed, 18 Dec 2024 06:24:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFtRdU6T9fjczyDU36xPulMKDITuG4yX5oo84uMCHGFDo5XudrAQybG+dnV4bd1kStWZRLnQ==
X-Received: by 2002:a05:6402:34cb:b0:5d0:e826:f0da with SMTP id 4fb4d7f45d1cf-5d7ee3b4ce0mr2712521a12.16.1734531852288;
        Wed, 18 Dec 2024 06:24:12 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ab5109sm5407494a12.16.2024.12.18.06.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 06:24:11 -0800 (PST)
Message-ID: <6d2e175f-0a84-4a6f-9484-c2c299bcc3c5@redhat.com>
Date: Wed, 18 Dec 2024 15:24:10 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] platform/x86: samsung-galaxybook: Add
 samsung-galaxybook driver
To: Armin Wolf <W_Armin@gmx.de>, Joshua Grisham <josh@joshuagrisham.com>,
 ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
 corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org
References: <20241216103855.18457-1-josh@joshuagrisham.com>
 <c23c4c88-786a-4662-a448-deb006b7a03c@gmx.de>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <c23c4c88-786a-4662-a448-deb006b7a03c@gmx.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HffOKa4qq6Slc-XSo30gYNpZtN_QYJDH44ujSGezWFM_1734531853
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Armin,

Thank you for reviewing this new driver.

On 17-Dec-24 10:31 PM, Armin Wolf wrote:
> Am 16.12.24 um 11:38 schrieb Joshua Grisham:

<snip>

>> +/*
>> + * Hotkey work and filters
>> + */
>> +
>> +static void galaxybook_kbd_backlight_hotkey_work(struct work_struct *work)
>> +{
>> +    struct samsung_galaxybook *galaxybook =
>> +        container_of(work, struct samsung_galaxybook, kbd_backlight_hotkey_work);
>> +
>> +    if (galaxybook->kbd_backlight.brightness < galaxybook->kbd_backlight.max_brightness)
>> +        kbd_backlight_acpi_set(galaxybook, galaxybook->kbd_backlight.brightness + 1);
>> +    else
>> +        kbd_backlight_acpi_set(galaxybook, 0);
>> +
>> +    led_classdev_notify_brightness_hw_changed(
>> +        &galaxybook->kbd_backlight,
>> +        galaxybook->kbd_backlight.brightness);
> 
> This is the exact reason why i think this should be done in userspace. You can replace this code
> with a simple input event submission using the KBDILLUM* key codes. This would also allow you to
> avoid any special locking in this case.
> 
> This would also allow userspace to configure the step with of the brightness changes.

As discussed in an earlier thread, there is really no good way to let
userspace handle this atm. KEY_KBDILLUMTOGGLE gets mapped to XF86KbdLightOnOff
while we really want Cycle, as we have in e.g. XF86MonBrightnessCycle.

I just checked gnome-settings-daemon and it does handle XF86KbdLightOnOff
but it only toggles on/off. In most laptops the cycle key is handled by
the embedded controller and this simply emulates that common setup to
match what userspace currently expects.

Handling this in userspace would require adding a new KEY_KBDILLUMCYCLE
and then adding support for that to xkb and maybe also upower and
gnome-settings-daemon and KDE and then wait for that all to land before
things start to work.

As for your argument about allowing to set the percentage to step,
note that this in kernel handling only increaeses the level by 1 on
the hotkey press that make sense because typically these kbds backlights
only have 2 - 4 levels.

So IMHO handling this in the kernel is an acceptable compromise,
(yes I do realize that this is a compromise).

If some need arises later to do move this to userspace we can always
add a module parameter to completely disable the in kernel handling and
instead send out a new KEY_KBDILLUMCYCLE key-code when this now
module parameter is set.

Regards,

Hans



