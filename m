Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFE81BC2A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 28 May 2026 16:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779984886; cv=none; b=psj21nuVWxe/WIbGEKl/voCJV48SNlbnQtDdrc2i8fz6V1Kj6wEYEAc+JLw2/kg+J+85HpNpNKLmlLMd+KKvhE72XWUbzIYCa8g/TNsRDQJs0C9EKVSV9OVFfXs/Cpvvr9DPYmYiXTtkOCdxTsb08EKtvor8507zhVDt240ZPgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779984886; c=relaxed/simple;
	bh=PHDLCXHLb6geoV+liXss4T/l8l490ju4aZ4ydPGildk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxB+Al78Bzjpc+ympW2799qW146cdtFOxvuGdmWmUcVR9IoBvZjMJp9Dniy+LvWOQHd4fjo+hnNtMMSCVJrb/RDX9p3fiReYJ+6wh+3R3OOhoZj7VFykwd25FPNwQKuunoBYwwDw0DYDMjxAcrmz7kjyo61yP5b1mjxlOk3Q+7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4908b92904fso12703255e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 28 May 2026 09:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779984884; x=1780589684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfCiAYxwM6fSi2FMKc9LgQjerGAgaqnqOAwHUcR+LT8=;
        b=qbH3MWe6NzDOjH5S5HtvCaaYUdhNqAB/lvq4yBPCCd0hSzwI51HqrWgaLtSXA4FW1C
         PhewAvaQHnunJrBJmidWcWguyO8zflj6ikUb5NcygWcxf+dgKiRO37K8iwOKHzQjZW5U
         uuvmlEZfLi3JQ6t6KAOx5VP5fUVEO59E1VcTGBLvtk82BgLXCMgnVFhXRP7COotlWw3B
         mvBSN0jOXYCjDE76yQoKYobkcz4uJTqoVMGjWFAh2+11YeCgyUjC8Uibr8xyTLK5Txsl
         qZzO2QsNuEJrx4f9+TT0yvxQbOhw9lYpGOTEN8NxOD4QXRLMZHipv5dJKtSoOul29EiU
         Mizw==
X-Forwarded-Encrypted: i=1; AFNElJ/3Obx31CrA+ZdT5mUuZfWWk7ZNI7Y0asx/QXvYosiHGb+JGJFXo6xdQcuZk0o9OpIFv9DQi5e+5CgoyxTIQk34Jnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcvS13MqxfBqAMlrWO92ofBR+mMsX9Mw2FM4C7/19EOsmIAxrH
	SsTem+ZrV/LGNuNwmaphnfLf+Sa64FwZRaJJL5vPRiWwvAkArIS7OhGR
X-Gm-Gg: Acq92OG3YMQzL3cFwKgXWRC8Yw3PDLobWFxXlaPj/8whT+IvB/MKVICC4EgerIL5qCa
	O5HFJpSYhwbsecn4XjY+du8B/QewohqhPwsuZDVqi5Kl73Cyq2YG+m94oXRFEER4id+aUZ/j0mE
	xoNnDOZCRDb70ulbq+X7r1YLiDx+507qoDaHXu8kEyEKR/cmwMGUa4mOtD/ep9Hl47s/nS8so3W
	JkFmusrhCpZO4O25rhp5n+ouPRXA+f9JWISg3pXGNhk6WPbNwgxbOtGw5NuGByaaDHszIIoHWTQ
	kT9akqKvmIvVFPfijR8R+bd6/D2xw3cG6/G5MtnOo0lisPAE0qGrLnYEf2jjoHdVKuUILDhTYY6
	juj+guN5spvnfx4ZmE6AQueIOCZmsPKzwrz+NgXRNisMC/zX+kZMYKpXfqSOr6Wd6VkOp0Q3jBn
	s2F9gt5hpqrzxNDsZ3oXxuzMUSilJ8zO8aStEh
X-Received: by 2002:a05:600c:c0d2:10b0:490:33b3:4be0 with SMTP id 5b1f17b1804b1-490426c1759mr350308945e9.20.1779984883857;
        Thu, 28 May 2026 09:14:43 -0700 (PDT)
Received: from gmail.com ([62.197.47.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909235d4c7sm45535105e9.3.2026.05.28.09.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 09:14:43 -0700 (PDT)
Date: Thu, 28 May 2026 17:14:42 +0100
From: Breno Leitao <leitao@debian.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Nathan Chancellor <nathan@kernel.org>, paulmck@kernel.org, Nicolas Schier <nsc@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 0/4] bootconfig: embed kernel.* cmdline at build time
Message-ID: <ahhpvNV91F6HUMeb@gmail.com>
References: <20260527-bootconfig_using_tools-v1-0-b6906a86e7d5@debian.org>
 <20260529001519.14ca9dbe92fb2622249137c6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529001519.14ca9dbe92fb2622249137c6@kernel.org>

On Fri, May 29, 2026 at 12:15:19AM +0000, Masami Hiramatsu wrote:
> On Wed, 27 May 2026 09:41:33 -0700
> Breno Leitao <leitao@debian.org> wrote:
> 
> > The userspace pieces (xbc_snprint_cmdline() in lib/, tools/bootconfig -C)
> > already landed; this series wires the rendered cmdline into the kernel.
> > 
> > Motivation: today the embedded bootconfig is parsed at runtime, after
> > parse_early_param() has already run, so early_param() handlers can't
> > see embedded values. Folding the kernel.* subtree into the cmdline at
> > build time gives a CONFIG_CMDLINE-equivalent for embedded-bootconfig
> > users without forcing them to maintain two cmdline sources.
> > 
> > Behaviorally, the "kernel" subtree is rendered to a flat string at
> > build time and stashed in .init.rodata. setup_arch() prepends it to
> > boot_command_line before parse_early_param() runs. Overflow is a soft
> > error: the helper logs and leaves boot_command_line untouched rather
> > than panicking, so an oversized embedded bconf cannot brick a boot.
> > 
> 
> Thanks Breno, yes, that is what I think about.
> Let me check it. And could you also check Sashiko's comments?
> 
> https://sashiko.dev/#/patchset/20260527-bootconfig_using_tools-v1-0-b6906a86e7d5%40debian.org

Ack, I will have a look at them, thanks for confirming the direction is
correct.

--breno
