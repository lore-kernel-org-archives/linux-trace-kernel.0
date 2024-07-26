Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C1B383BF
	for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Jul 2024 19:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722023916; cv=none; b=GuWYI8mr48Wu3juQYUuRfTbKE5CaNOAUC2lmSLU6y+VIr0bYaqLG/1NCAwoQacNCYHcPCnyCYg2utKNVZqx0MwNwsbj8Kxlc+wJNT2q5t+/mOOl+Ol0DMH3Ntw31HURaUJ9Q6ITKUtokkTWepP0Hj54hud2rM70wR+J+7Ag65n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722023916; c=relaxed/simple;
	bh=miQxgJfJvHOqBniMe0A0vbvBAO5moni5RerjEZW1diI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NqKQ6z53P+/LTRMzkVhgDJ4e9cB8Jsb/jYR1CiQWTQkf50dq+IH0mvFEPXukVjrlqdIOTJP/ZT7i6S7vp2wqk0Y4DOICsu2+ehjtdYhJO4mDcXpHI2jaLAAxocBWznTRrAZRsPNUVFweyrGIOowl1rb7fLZ2+Vy0CqFKQn7mKsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=pfGC45y4; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="pfGC45y4"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-368712acb8dso21362f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Jul 2024 12:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1722023912; x=1722628712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Mk/yljKOU+7KU+lHGNwwrz+kbpzw8/mEgAnkflW8uzw=;
        b=pfGC45y4YoqUhESkiawB3p3TiGN/+hWRkyaLh47VOR6CZDDmW09fN3WKqqz6LUDBPh
         58VsoXZ5YyIVwoVyDIzKcSPLKo34V7I2+GKBLZ0Grwtg0TvIxEMZWiPeqERTu998wXOD
         oCszHi4xlEPh9dgbSGe4MT5ThQFhMDWx2VUfDtYnGnvFO9lChjSoKa99AqBE4+0Vlc7J
         DDLlLOf2thrDWzJaspZ8RN8AQXDC/Tsh/6r0ncjYvFVBUOSCIkrujVVqXKg6WPB4TTua
         ctYJzeucOqXyuYMrlbCgRqCdquUGumEOZ5JcBPBxyPEgHfPOGjiOZ7IHb91INTDbCvtQ
         9byg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722023912; x=1722628712;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mk/yljKOU+7KU+lHGNwwrz+kbpzw8/mEgAnkflW8uzw=;
        b=IZvqa60FbeIaB5VddOAPuAF5j+kAw3fzbgjQOE1Lj1mRl2UFqmC4iwOXb57jsUEs0v
         6yeP4Rdm5+EeP2rU0ht4x14w/HA3tmLDBV6rEuOtec0L7+NORvKrppt6Oo7KRx0XTv20
         jcdmGNOKdXD5DPoI2bqhTNwBzH0GHxj1HJSR+mrxNKQAQFOgqqDhYHShy6fCBEV7VJsC
         WAcA4Lrzn+jGZK1bYa+PlQIiCFzqjcdX4GBuj95VKwl0aK/HWNiYWA6azn1khevo5RAz
         lnlXclec7CgoXNqh5NT87yF8p7r6OLw3ifi0LGvhj+eTe9CThiU9h+ezLsMHV1ZAraGh
         3Vtw==
X-Forwarded-Encrypted: i=1; AJvYcCX/DaS0ihKzLy3kmG7r44YEn6KFWf/1dQ4ePa5DpRSj3cHq/a7NwtOmiK5G3MgFay6MOMPOC7TlGixsqXjYbxfy+H9F9p+/ScgyD0T98nD6gYjf
X-Gm-Message-State: AOJu0Yxc/ZIkuSWQPxuFYvkiQpbjxyyH+Ux9rfqLckdiTax4mFDEbjkG
	AS/sKw85PHJP9Fet6xNX4bB28Utd9+wxCU0QDhk7Ivav1VzF+vWr2MHA48XVgnI=
X-Google-Smtp-Source: AGHT+IGPKjqjkSpV3URko+5dc4l+RUrGtcv/S4U6RPzgnGOPPt8la5WZ64y0NVr9/KAIMF3uN6P2gg==
X-Received: by 2002:a5d:52c5:0:b0:360:7c4b:58c3 with SMTP id ffacd0b85a97d-36b5d0c2df7mr428367f8f.54.1722023912308;
        Fri, 26 Jul 2024 12:58:32 -0700 (PDT)
Received: from ?IPV6:2003:f6:af24:a900:7e45:2c14:7bcc:f1b? (p200300f6af24a9007e452c147bcc0f1b.dip0.t-ipconnect.de. [2003:f6:af24:a900:7e45:2c14:7bcc:f1b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b3687003dsm5890836f8f.115.2024.07.26.12.58.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 12:58:31 -0700 (PDT)
Message-ID: <ad2f644d-b77e-4cc5-8396-f02214010103@grsecurity.net>
Date: Fri, 26 Jul 2024 21:58:30 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Have format file honor EVENT_FILE_FL_FREED
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>, =?UTF-8?Q?Ilkka_Naulap=C3=A4=C3=A4?=
 <digirigawa@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, regressions@leemhuis.info,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Vasavi Sirnapalli <vasavi.sirnapalli@broadcom.com>
References: <20240725201517.3c52e4b0@gandalf.local.home>
 <0b80cb48-6604-44ec-bfa9-f5ec1fc5d7d7@grsecurity.net>
 <20240726105212.120a74b2@rorschach.local.home>
Content-Language: en-US, de-DE
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <20240726105212.120a74b2@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.07.24 16:52, Steven Rostedt wrote:
> On Fri, 26 Jul 2024 12:16:16 +0200
> Mathias Krause <minipli@grsecurity.net> wrote:
> 
>>>
>>> With KASAN memory checking, it would trigger a use-after-free bug. This was  
>>
>> The UAF bug is there even without KASAN. It's just that KASAN makes it
>> much easier to detect and catch early.
> 
> Well the bug happens without KASAN but the "tigger" is shown by KASAN.
> I was assuming people understood that.

Ahh, okay. I'd written "report" instead of "trigger" to make it less
ambiguous.

>>> because the format file was not checking the file's meta data flag
>>> "EVENT_FILE_FL_FREED", so it would access the event that the file meta data
>>> pointed to after it was freed.
>>>
>>> The second bug is that the dynamic "format" file also registered a callback
>>> to decrement the meta data, but the "data" pointer passed to the callback
>>> was the event itself. Not the meta data to free. This would either cause a
>>> memory leak (the meta data never was freed) or a crash as it could have
>>> incorrectly freed the event itself.
> 
> I need to remove the above, as I realized the release callback doesn't
> get called for the "filter" but for only the "enable". That doesn't get
> called until all files have no more references. So there's only one bug
> here.

Yeah, all files are covered by the same event_file and only "enable"
does the final put.

>>>
>>> Link: https://lore.kernel.org/all/20240719204701.1605950-1-minipli@grsecurity.net/
>>>
>>> Cc: stable@vger.kernel.org
>>> Reported-by: Mathias Krause <minipli@grsecurity.net>
>>> Fixes: b63db58e2fa5d ("eventfs/tracing: Add callback for release of an eventfs_inode")  
>>
>> That fixes tag looks odd as it didn't introduce the bug. It's some late
>> change to v6.9 but my bisect run showed, it's triggering as early as in
>> v6.6 (commit 27152bceea1d ("eventfs: Move tracing/events to eventfs")).
>>
>> git blame points to 5790b1fb3d67 ("eventfs: Remove eventfs_file and just
>> use eventfs_inode"), which is still too young, as it's v6.7.
> 
> But if you look at the commit I posted. It has:
> 
>   Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode")
> 
> And you need to add that to apply this patch as it has that as the
> dependency. If you try to apply this to the change that had the
> original bug, it will not apply. I basically say that this patch is a
> fix to the previous fix.

So far so good.

>>
>> IMHO, this needs at least the following additional fixes tags to ensure
>> all stable kernels get covered:
>>
>> Fixes: 5790b1fb3d67 ("eventfs: Remove eventfs_file and just use
>> eventfs_inode")
>> Fixes: 27152bceea1d ("eventfs: Move tracing/events to eventfs")
>>
>> Even if 27152bceea1d is not the real cause, just the commit making the
>> bug reachable. But from looking at the history, this was always wrong?
> 
> All stable kernels should get covered as 27152bceea1d has both a Cc
> stable tag and a Fixes tag for 5790b1fb3d67. And the stable kernels
> look at what commits have been backported to determine what other
> commits should be backported.

Now you lost me. Neither has 27152bceea1d a Cc stable tag, nor a Fixes
tag for 5790b1fb3d67. It simply cannot, because it's from July 2023
(v6.6-rc1) and 5790b1fb3d67 is from October 2024 (v6.7-rc1).

>                               By saying this fixes 27152bceea1d, it
> should all work out correctly.

That would be fine with me, as that's what my git bisect run pointed at
as well -- the oldest commit triggering the bug. However, in your v2
it's still b63db58e2fa5d (which has a Fixes tag for 5790b1fb3d672 but
not 27152bceea1d) which would suggest only kernels down to v6.7 are
affected.

Thanks,
Mathias
