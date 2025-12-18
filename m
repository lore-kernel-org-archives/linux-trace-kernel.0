Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7117C2F3621
	for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Dec 2025 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766048961; cv=none; b=rb7gwjqHSHLsWZIrfB+s8N8A7cmKLqxH7i+upDFI3j4ulxXlR+76k5YXeYXSHxAQWE13ouPFQJsGvyiIpbd/FDtp7HbiOqlQvJQx9snyCp3Vacri95nx0EpTo6sxnyTPKrKdbSB/Zy4+InLOLumfB/NVimSxBjLICoKqSlvlIv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766048961; c=relaxed/simple;
	bh=xxT/SxIGJkljEhPJaJG/jzfe8Jhuf+sTOhwp7mqcsqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2UaRhd1oT1oxbP3aFWec/DuBjsJZzlLZyS/tTkPsJKlbPj1cm6fybmdMI3k9uUlkzUScjsU2XrscdrDxdYVlvlvzzqZe8ERpRUKg1LtWnkgxenSdeyNk3dRZYsZ1waxIK4i/5/3J9U65eWyPO6paFVMgeVGaOYtkXFIraqYgkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aVMlaSDD; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aVMlaSDD"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-430f9ffd4e8so724610f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Dec 2025 01:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766048958; x=1766653758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OwwKGkT8jQ+mkcWG3dVItAZ5McCTnVMRZyiBYaakX04=;
        b=aVMlaSDDCtEqbV8823rRbTgGwbSr5wrQfzelFk2mtGAtWY7inpuBZRbJqiyM0Ea9Oa
         mAoYXYxr/KnrunWTeckjTD4nHWq8PbvK1LK2c5hSE1SbYR7m5mD77/M8vZ+3LyRYdvjy
         otlANRz3raKSFBpQ/GT10HZEsy7ujRKgxhUw7aOzApankECs3Q4LBY0C1PeCpEU08PoE
         YyrDz2lxXbU1c2Z6lGbexmpNiuTHveEA+3duEGzeWrN9s+1NHaVtfp6dkx0XU0/xF17l
         bQuYMPvnvbIpXauLVusF2nHUKu/Swu7Hj3lY7cZvYG4F5N0GCcj8kYTAGE0OvbQscyjI
         LvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766048958; x=1766653758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OwwKGkT8jQ+mkcWG3dVItAZ5McCTnVMRZyiBYaakX04=;
        b=nrQm/MnFp4lrLxSPzq/IcKpQtb3PH2mCKdElv2dZrfwJIGnGQ26hkKurLIyYP4GyWN
         Vw5BrgV3z2AmydcjojLPdaq5a5ENg8jYlYYsDDN3YMDxdKdQKIwQpcZj+wrl85vZZps2
         +rC+EHUe3gX4ZJ9ue1aO5RNxeVy4Z0AH6VbN37ts6JFBjFDlJV8RGFzYvKX+9dJpTjSE
         YZB2NDWOCmDDlX2u4GclrE5VH9jd8+8OHEfQg8pyBE6eDXLfeRxVSd2aQTrig9UIx/QM
         wLsy0eGYEjuDEf3gRoS07TqplWN+WF3D3YBgpeMqKqZYgT04vMTzwL0DUd9QIwpWFtu4
         YnUA==
X-Forwarded-Encrypted: i=1; AJvYcCUjCnjaOtbd2024Z/gStxkkcg4pc/juYThewmFGJYwKHHh7sOtFlD6AgkXgD0cdWJJ6sRmU+UYH6muDe3VmBjEA5dA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyseymEuOtlBYMZGa+aR/Q3t+OQb+VFmx0EOVyzwWpueiVJPzW4
	kK97ucz2Osl2X+8byLNqF7FJA2RwABLq0nLdyRH7sC3/GHz8WksLv6+4nFZLZH1Asqpo0qhoakY
	/GEVF
X-Gm-Gg: AY/fxX6Lf9q9ICJX0r81nvJ1l0JMcbaSvOb4ska/m9xM5/heHo9RX3eUgO4BRE/4bM0
	j9dTspvWdVT7YOqffI9J4OLHfb0OdRm4wQQb/ag129uouULLgscEU2kX9Dzhus8q0ZIKgM955l9
	TCwKYrckZiXqDSxbSpS98KQkgei4o36M2OZlGHTO+V58Vg81a+ckoPsToZ3/AZNWrFllYhVGgRY
	JcjLUsesIuzDcTl3ysSHcz80ShIxE6WpcnjehLKwM6QR12hHCilDs7slqG9uk1sAE8ZxBgGsu7Q
	pYNsq8yVpJa08r4g7B8DcsmwBUgpnG2xQTNvzd0VIDa766cfxKZQj9604agKDZagypygvfseMDI
	PWn8Vnm5L1Vfn9Hh98f6Xc1Cdwb6aDTX4SZLOgHsgIHi6hgP0rwQGKZRuuOACFZRRCpwh1gBFgf
	xpXSqJnvUcxor/vA==
X-Google-Smtp-Source: AGHT+IF2Dw3MO5Fpz/OaFRcBV9fS9cLrSTXBGYv7yLVwKCoH2iVNb+O20dDu2owV0ukJ+8lTxdTkqw==
X-Received: by 2002:adf:cd91:0:b0:430:f2ee:b21f with SMTP id ffacd0b85a97d-432447b2173mr1831219f8f.22.1766048957796;
        Thu, 18 Dec 2025 01:09:17 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244949ba6sm3846440f8f.19.2025.12.18.01.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 01:09:17 -0800 (PST)
Date: Thu, 18 Dec 2025 10:09:15 +0100
From: Petr Mladek <pmladek@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>, Kees Cook <kees@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] kallsyms: Prevent invalid access when showing
 module buildid
Message-ID: <aUPEuwRpMlAoy5SR@pathway.suse.cz>
References: <20251128135920.217303-1-pmladek@suse.com>
 <20251217130904.33163c243172324a5308efe9@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217130904.33163c243172324a5308efe9@linux-foundation.org>

On Wed 2025-12-17 13:09:04, Andrew Morton wrote:
> On Fri, 28 Nov 2025 14:59:13 +0100 Petr Mladek <pmladek@suse.com> wrote:
> 
> > This patchset is cleaning up kallsyms code related to module buildid.
> > It is fixing an invalid access when printing backtraces, see [v1] for
> > more details:
> > 
> > ...
> >
> > [v1] https://lore.kernel.org/r/20251105142319.1139183-1-pmladek@suse.com
> > [v2] https://lore.kernel.org/r/20251112142003.182062-1-pmladek@suse.com
> > 
> 
> It's best to avoid sending people off to the WWW to understand a
> patchset - better that the git history be self-contained.

I see. I'll do better next time.

> So when
> staging this for mm.git I scooped the relevant material from [1] and
> added it to your cover letter, as below.  Looks OK?

It looks OK to me. Thanks for taking the patchset.

Best Regards,
Petr
