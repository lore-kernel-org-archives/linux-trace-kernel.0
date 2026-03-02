Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278C03E8C65
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Mar 2026 13:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772457347; cv=none; b=OVjzWpv1YDBjvEG+mE1CC7fIAzTDU0tf/6XmVFIH6U9eHKA3cy+4szuo7Qoya+8UTQVW3yfTnFwCKJh8f/1IP2PNwc5FU+U9HmslnfcjqtiKOtX4kfVbqbGLwDULbn4OMtX07uJJUCoMlIb49hvaDenGngMMbZ7hdnecRt9JihQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772457347; c=relaxed/simple;
	bh=JV5gSZRhPiMnRwmWCCQiBvuE3NFV3+3iTTS8WPm+N7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mpd5GY+6Nc/o9uLOvwlchgXRmym4R9yPZAyO1BbtgzOoxPoER3mY7D8r04ScLu76OWdCt5EbFAc+IGQEAMaiuxZBsrTSPyREVGmq9AVQTwLpmeK04LTgUAe+YQBtZscH585K4Ymn/cJp7FYxFdeJR66gs6JMoUlgpeu2JbZLhAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=kP2OkOx1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="kP2OkOx1"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4836e3288cdso30836555e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Mar 2026 05:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772457339; x=1773062139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DHkP/futS2zgWyQTyC5FXIesale6XSmEvAtzel8W+sM=;
        b=kP2OkOx1OGk8QzCJ6cnKlczbiViedPD27Ke1MImKIvKEN29UhPXB6cIS7krZpIPTg7
         UtmjFCmAQS32toy1Kky0VUYQ6nknRRVluwBbwXHw6cWEZNCVAgS5EELzDaqzeBLSo6Hl
         6MBO8HVZMvyD6PlHRN33vJ1DlYOmwGHcGRfuGiwe7PpC+cjWOvs5SOS4yXY3lDq7hvss
         zkaT8t/3Cam4w5r+FQXLTIz1sN4S7eEd1VX5QajWDFRjikohyMIelygNs2O2oH4ZYw0Z
         AUAaYJJMMI4yT+7+5mF04/q4qHGd5KDFQKS/68y4IqW0DIWdfkKgJUsDRnvSUoosIJpM
         kiiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772457339; x=1773062139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHkP/futS2zgWyQTyC5FXIesale6XSmEvAtzel8W+sM=;
        b=kd3D185jXaqke8wHy0ceOwt/4COeBoZ13KwwmiD4JeBiMzyo5bRK8o2rcmIVHTTRbi
         Aqr627IPiOUUH/j7bNxFGtHYWVpbI6zP+GN6/OsgymnGn0QYKDCagp1h+B8k+czrUv2Y
         frH2lJkelazrrQumsB4VTQRXQ0LVHpCo0ZaiCv15y1wNiigxWgGj1oP/zgTOEkDae8Fu
         sD8lm9ldI7QJWe2eAzk25bSSfHFjumwPzbidmAPSaV9cYmZ+OK/BiEx+Mwn245kfEoUk
         +GxUaWc/pj0Ww37AXqLb6DRJDMbE/nx08Z7COpwKUD3Nnn+mu02RJH/6XWa6QsSeNAAi
         hEQg==
X-Forwarded-Encrypted: i=1; AJvYcCULwbFsUqq4dAOU4Mq4lQ++qSIVuHsW8cBOgIgq73COR7/WoaysT3pP+PDI85rjSIGC5CngZOrClUC0bHTJpoESWi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL/zRHa4nTld07gQU7NWmJTEf+97JkpDGzt0x3GTCfrNCiM4DD
	zfU6FCOf91H150uuugoycoaTY1mVC3E7qB0EZx9/wRnSNHVN4fR/Inft/CYyqUwyBcg=
X-Gm-Gg: ATEYQzzSPX94weCmWKZmuO9H5jnepzYWcPJO70+GV5MU2hiH8SJOOMcR/OBMU3bqGn2
	0kBm0xY8Ay9sNyZ3yL4lfShQwArspnvU+A74hMK7fFz9aG/F7MCaSXZ3YPYg3D362pERWiOz/fu
	GFKpqD2DTPdgcWL43qK5Xp0Ok2dwRVaxWGFMfqIWjDpcT2wqigK4itlDOE5w321s4kjwOGIXf4n
	aClBHlV47Vfw4eSbtGFRy87p5/q/SDD4GoqgwhUn/2THjPQbVgxDe4zNPX5qgmyw2lBnbp+Chel
	BsoJ4PB/sfU3MrkPwVtWdevW2zYXKsJdIgzSTLsIAeDNyaDwjy8KkpuEzzzGwylxs9IE8y9OVso
	mebh3qAlJxchV5sShRpAHmcV2DqK+4KZYLSHazCa+9cSu2QwQIPNgNC79SXYxk62WmtpfJFpXdM
	TLZR52TTHLmQ1Boji0cNa5SQBwMIvAkr6yOSidaQYjplY=
X-Received: by 2002:a05:600c:a010:b0:480:4a90:1afd with SMTP id 5b1f17b1804b1-483c98dc373mr207220875e9.0.1772457339037;
        Mon, 02 Mar 2026 05:15:39 -0800 (PST)
Received: from FV6GYCPJ69 ([128.77.52.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b3d24dsm245616515e9.5.2026.03.02.05.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 05:15:37 -0800 (PST)
Date: Mon, 2 Mar 2026 14:15:30 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, donald.hunter@gmail.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, 
	mbloch@nvidia.com, przemyslaw.kitszel@intel.com, mschmidt@redhat.com, 
	andrew+netdev@lunn.ch, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, chuck.lever@oracle.com, matttbe@kernel.org, cjubran@nvidia.com, 
	daniel.zahka@gmail.com, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 07/10] devlink: allow devlink instance
 allocation without a backing device
Message-ID: <lkotihkrjr44jguht3cbj4kozxykqdzqedm7rm4cxuilsy76s5@mtuhatnluxgh>
References: <20260225133422.290965-1-jiri@resnulli.us>
 <20260225133422.290965-8-jiri@resnulli.us>
 <20260228150138.14e35ee7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228150138.14e35ee7@kernel.org>

Sun, Mar 01, 2026 at 12:01:38AM +0100, kuba@kernel.org wrote:
>On Wed, 25 Feb 2026 14:34:19 +0100 Jiri Pirko wrote:
>> -	dev_warn(port->devlink->dev, "Type was not set for devlink port.");
>> +	if (port->devlink->dev)
>> +		dev_warn(port->devlink->dev,
>> +			 "Type was not set for devlink port.");
>
>since I'm already nit-picking - maybe we should have a helper for this
>case an pr_warn() the message if dev is NULL?

Okay
