Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4337E1DDC2C;
	Wed,  9 Jul 2025 02:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752029767; cv=none; b=Pc51I0SFVyfOJRKplEFPTArTGFVOKllSZm9VY9obISCYgp7iIbwc4DEwnfvJUvnHUPQNpmUGCHA39wCWnNWwsnPNEtXrjAq+3SrrCkVycKzYKHXyaJBX2RCPDCYHXVbin4+zx7RFsyyRls9eApgVC+FA+AY5tc2b1SrWB+XjN1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752029767; c=relaxed/simple;
	bh=p/ciEE9HcVE433GjS0DECMhF/e7opacg+olX9yrt5nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2DTi2Be2PNSry6GrS3ZkOk/RCQeT3aMpUWWjSTjSooVqRASpNwWXl3rEElFRnIVW8ZQZP5zjV1Z4ImvjetPfyfgRLyd5CbchtOVAg13VtgO61TITJR/2dAafMHaSkfCGKsQ7O6JR+dF/ZTouDQjMy3n4HxZg9OxCjE3vftL98w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exH74+KR; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exH74+KR"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a77ffcb795so47438291cf.0;
        Tue, 08 Jul 2025 19:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752029765; x=1752634565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qALNLa9XmLO7qdNG6SKa6DOpNdEl96gwsK9/iSLCW04=;
        b=exH74+KRITcW1G2c1mnlqjLHccOqBABiI0vBy45f6sCD4Z8o16RRjO5lsFdXN0pWMj
         iGzKRbAe3qKXBdJzsf1hEOZbC1qtphN08IWJPiiMANMsGU0bO1//ADsx31PSp+ZzCh14
         Guye2jH20F52bCvjommrURGx2LRONyy4PisB8W0nAPCbF9Q8ulc3hvd7cVfZmA/MfUoY
         k8yhHRdFv3nqAyHASJ9XrvvqmXGBKx7maJWQ1NSHkP32eGsWwfek970YHloEc5VJseG9
         gfNdUfVnjK34HdYhn0VEEPsV56jAd/wqOkkmMFsSW/p8eD7j5BXyb/hDGCs7UqiPSqfR
         4p9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752029765; x=1752634565;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qALNLa9XmLO7qdNG6SKa6DOpNdEl96gwsK9/iSLCW04=;
        b=wML77OYXY0T8sDODLeYd3hAlj+weWz2kJmiyRAGW6RbcqNEpZkZB9qEEiaJYSMkurl
         07xD5HyGXQmMTyHvCv3FsHcDYwhLkd5mfgYcsefXCbz+j/+bMKORJUTiQ+g+gYFZUgcb
         pOVazvGPVAcxVnCAVL5UQzdUwxtVx3js8dHflXdipyAa+NDoqI3Wx5neiH3XjLP8Qvb1
         rnoOusHbtHd36dasFN6nuut+jNl7gm7PbW4WKpq5o8OOZteQr3Dmhp894GlSsTdSJOkt
         09yN/eomOPIglfLTe4AY1HnTce+R9wTMg0OoHFrh/9gS1XelJO9nwjhJ78ctGjRY+Rfs
         gf/g==
X-Forwarded-Encrypted: i=1; AJvYcCXq92BhsZ7T0c7M1j45OpXRG4xwckcbQNwcNct3+7H5GIueHf5Vp7+qczRo3WH6mNLzvL9UbysbviSl7N6JoKcZ5e4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQkctqVaZMt8B14HJTCwmOxXHMsziQmF5mpcAtUqwcubSda6pD
	wGihNa0TOulITtFVdYwR9PPxqldVoRY0sg2bMTOBtYOrUnX9RPKu8MdA
X-Gm-Gg: ASbGncsF2/xwAHlYYNn2ywgVc9eb5zyRUbg3eHoam6/BvNUieL83VO/WrluhmMbrmV1
	hB+PDSr4VFHOd2tFZbZ1Q7SI/nXGLsyx+1ISCZP8o4BypI/hz1BTv8+PnBWXrtKAKMFfskkj8dF
	OT+bTKotnW1Y6i44X8XphQMJ+Dj9NmNBeWHjPoI+PZSYeqg8OUzcxciN7dTWGEjXrAfMAi8GaYY
	4znkRckrgr3wG8DX/SGqkSPIviPN3xB40jdwAuiZkuyg9hZKVCTdh14tGcqC4avZ8lzDAHbJsMI
	46xWkNDdSttTGi6D2lnlJ1E1XBNkdljaqd9jD7tY82frYOfkW/zjtvS8
X-Google-Smtp-Source: AGHT+IFfmP4qx+dTgm3hzxQBsfILPuPkim1avrCMHle8DPqkiv1q+9Fm2Zds+5XzMmee5z2gKjc7HA==
X-Received: by 2002:ac8:5913:0:b0:476:7b0b:30fb with SMTP id d75a77b69052e-4a9dec96a6bmr11001151cf.22.1752029765120;
        Tue, 08 Jul 2025 19:56:05 -0700 (PDT)
Received: from Gentoo ([191.96.227.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a994a8e1ebsm87872351cf.59.2025.07.08.19.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 19:56:04 -0700 (PDT)
Date: Wed, 9 Jul 2025 08:25:55 +0530
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: bootconfig:  Regex brackets need escape
Message-ID: <aG3aOy4LaUp1JOf5_Gentoo@unixbhaskar-laptop>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20250708092204.1558-1-unixbhaskar@gmail.com>
 <20250709111254.e85d0238a0e286dec33a3e46@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250709111254.e85d0238a0e286dec33a3e46@kernel.org>

On 11:12 Wed 09 Jul 2025, Masami Hiramatsu wrote:
>Hi Bhaskar,
>
>On Tue,  8 Jul 2025 14:46:08 +0530
>Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
>
>> It was showing malformed syntax colors below those lines,escaping the posix
>> class brackets bring back the syntatic reference back.
>>
>> Oh, malformed syntax colors means,(in a editor,in this case Vim, where syntax
>> highlight is on). In essence, it might complain while running the script.
>
>Hmm, that means your editor's parser's bug, right?
>
>>
>> Hence, this trivialities.
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>  tools/bootconfig/test-bootconfig.sh | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
>> index a2c484c243f5..211409539737 100755
>> --- a/tools/bootconfig/test-bootconfig.sh
>> +++ b/tools/bootconfig/test-bootconfig.sh
>> @@ -167,8 +167,8 @@ echo > $INITRD
>>
>>  xpass $BOOTCONF -a $TEMPCONF $INITRD
>>  $BOOTCONF $INITRD > $OUTFILE
>> -xfail grep -q val[[:space:]] $OUTFILE
>> -xpass grep -q val2[[:space:]] $OUTFILE
>> +xfail grep -q val\[\[:space:\]\] $OUTFILE
>> +xpass grep -q val2\[\[:space:\]\] $OUTFILE
>
>Can you escape it by quotations? In that case, it is acceptable
>as a cleanup. e.g. 'val[[:space:]]'.
>
Yup...looks sane with quotation....sending you V2 in a while.

>Thank you,
>
>
>>
>>  echo "=== expected failure cases ==="
>>  for i in samples/bad-* ; do
>> --
>> 2.49.0
>>
>
>
>--
>Masami Hiramatsu (Google) <mhiramat@kernel.org>

--
Thanks,
Bhaskar

"Here's looking at you kid"-- Casablanca
https://about.me/unixbhaskar
