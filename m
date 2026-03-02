Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F7034CFD4
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Mar 2026 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772442563; cv=none; b=YS2nZ7Gbs+n7D7aAbXQQ5nQxNYSsMA0/jq0AyPdNfi03wSBJc1AaP/r++5pF0my/2wtC3HoKEbhIV4GppXkrHJkO45E92QM+6URjRlLyQhVLykn2/KbgMOpo70AJykCpZIgHvTvSemIF6Q9V7hS2MWl4KEWDui87cN4PI+4x3EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772442563; c=relaxed/simple;
	bh=ilMQGVCasLEyuVKt3xmPGLbzaexBUt4hoMGNq/qop6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrX/NUVqTkxvVxa03Fl/idv1WwMb6rVQd02KLWbF97RIDhrZjdwmAZzcBpX/TAMh/175lDLK6BSlXqUsxkwwSGckwAQ2aBgUJRbGfWUW/QnY8NgwJIfpdYw0dGskIZYrI/heB9QAmYS7v9U1YbstR+KtY7BkSXSpA9SUY8ry1jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=AMVKFmcg; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="AMVKFmcg"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-483770e0b25so36420545e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Mar 2026 01:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772442558; x=1773047358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ilMQGVCasLEyuVKt3xmPGLbzaexBUt4hoMGNq/qop6c=;
        b=AMVKFmcg4l39oJMarm/bn5uahr/tJ9jjFRlKIlqA9xsQAKkyq4jjrLZRY6EEKLVk8f
         xm7DzBNyWrw6PnPJnMUyxa8fDXWDkd8ikJiYnewReUGwhNSdcPaqzdkTh6nUAvU+XU2T
         xEsQjdgHgZQCq3TBUyCudQXI88B6yGIyRoc08x7bPK6sTBOhcrwOyMpJHJtf9zMxdAEE
         QMiaeRLSCNLbfbu1ATqdUGq80PwNz7MUeHUKzeoLegcsotBwwzziUtrw+eDaOcHeuN51
         U0K225TJgdXRYsu3xyaxvFsHcSPZuouu8gMh5cDO+e0FIFlHLaU7hO2qumGnjIGFVGs0
         1LDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772442558; x=1773047358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ilMQGVCasLEyuVKt3xmPGLbzaexBUt4hoMGNq/qop6c=;
        b=hOegupPWC5P8OcDdhyXaJ9B4/6rZQ43OZMGyezu1hkFlCWKfgaWCbsrqxlDp1E0dOD
         rkXJsmEGjT07prCPL47rNjbmYzG629DKw8NIbEE1YMV3dLWTZWxy9yyEMDvL1ZiDFkeu
         VPn+0Lz5F4Bc1CX1uFUJtMAl1WhSnNIMPLCAyHW8/6SIGxJ+LkZiq4+f3XHVGmVdWNGU
         C3+ZO8Z/9AOv/vmURiR/8B15aokwXXrViUWFHwSoc52bSLxf1c7JUERYvHGXZHFhXjzt
         RmsIFG/KWRQhSNRPXn2X/CFrUq9FtOWVL2txquLdDC09I/ds1LVQ/iHPylGGJyWe/8q2
         zdOA==
X-Forwarded-Encrypted: i=1; AJvYcCUbL15F67x8btRe+rt4EbVPhv60x9bcSnaYLF/MFQyTyysUgs38JuiW3xm+bZYmBZjZi5IAVhutzl/BadT16ehiKk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+nNcJIGonhBDW1xb5WXYrd1TFxTgvitaoTBHxbgiVIHHKtj4s
	E12xqHnTIBY2mNi3+7FYSPHqRG0hzHn3wg0LXiTCE/MyyhPx8+/58CVzzfAtphgAyXs=
X-Gm-Gg: ATEYQzxEY+bW8uHgs//TltHAwrJm7qHswzjgvi1LouJtkSuA1pv6GyrnSnqgIlOotbE
	gDIPNlU0QX37nYlHT16kMT1HTTeeu3LqGTVGQOv/REIfmek1BxCjxb7aamqYd2yECXqODqXOMPy
	miDPWOV+Cxp9iT2UxVgZLn208wVfOj6hFAXpe6dZTHFcJ/iTGgxeGnryD9W98vSPODDEYxI3GFa
	Aq6tKzkarB9YaRdom1pUzNUovi6o1JVNV8sQ689LPkVvkizg1F9AehPw6rknaU7TsFRXS54HUjC
	GlUymEYrwW8g5fJla3oQblep4u6CISU21Jeav2DdTjbL0RCpwxfpAZMr5HHtPDjmb9CTH83AGFE
	Ex90/KAKxrHUyfXBznaOIvFlSWW/P7RpB8VAoE+HJYK6+Ck28KYg6uFUYEggcm/1GhITlTfv/cs
	kZ+qsy8cdXGGwpZPcnssC4ZmFGScg8qTETmUXfs7TOhUCP
X-Received: by 2002:a05:600c:3b18:b0:483:7631:befa with SMTP id 5b1f17b1804b1-483c9bc55d6mr190142375e9.5.1772442558003;
        Mon, 02 Mar 2026 01:09:18 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd68826asm633954365e9.0.2026.03.02.01.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 01:09:17 -0800 (PST)
Date: Mon, 2 Mar 2026 10:09:15 +0100
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
Subject: Re: [PATCH net-next v2 09/10] documentation: networking: add shared
 devlink documentation
Message-ID: <wukj2sqty6p54lsedkquvija4fm3xjgit53ukomnx4pgymxpsb@pwbyampuhj6k>
References: <20260225133422.290965-1-jiri@resnulli.us>
 <20260225133422.290965-10-jiri@resnulli.us>
 <20260228150558.46f3be36@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228150558.46f3be36@kernel.org>

Sun, Mar 01, 2026 at 12:05:58AM +0100, kuba@kernel.org wrote:
>On Wed, 25 Feb 2026 14:34:21 +0100 Jiri Pirko wrote:
>> +Shared devlink instances allow multiple physical functions (PFs) on the same
>> +chip to share an additional devlink instance for chip-wide operations. This
>> +is implemented within individual drivers alongside the individual PF devlink
>> +instances, not replacing them.
>
>Sounds like you want to preclude what was the goal in the discussion
>with Przemek you quoted - a shared instance _only_ case. We don't have
>to implement it today, but I think it's an entirely sane direction.
>So the docs should not state otherwise.

Fair enough, I can do it.
