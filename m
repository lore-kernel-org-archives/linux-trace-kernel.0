Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DAD38E12D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267894; cv=none; b=HRDd95gG/rGIE4NKG9okoZqmeqqCLER54YjhpMyGY3BiOWYUZ8abok8nRJKKA3nI7+9JtEV8/t5B2Xz0q6D/JPZrjwK/Nr3dHQd1QxE/wAb/fMlQeInzSyTZQCW41A+oAXuaVFFkgBOxaTZuAcNP9vNMAGAtsx/bidrlPJ8EtFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267894; c=relaxed/simple;
	bh=Y6dfgoDu9ENyHz35342iESy0PYqePxl/sIn9jSurkUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k82jQ0OmtjemQNj0cHBnyrwKaxGxKBGWp0JpZeIsFZ1FVX8Wu3UmsQAolOY334Aal6YNfkHV1O6NGMONctFh8blThgaXE3w6QT/64vPALPCU5Z3Y1cw9iGF1M4OX9kcA3QxH1JSoQd5LqOdsN7yXU7kdh7R89KbVQdQqMozsOJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=DELaQ6H+; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="DELaQ6H+"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb76543e2so141161cf.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 09:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790267891; x=1790872691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LuPrvXBzY5FQ+f/5fzbveR9yF272P1V2+jsIcGJNdC0=;
        b=DELaQ6H+GoqYKhSPbbw83I2UghjOPLUKt/HJzwYXOl5vd4By1b/ewKsZIbd9ahXhZb
         TJDLBT2drAnq8j1D4gtZjKdZE54vfhHIW07z7SMjyhNrpJZ88lIXL27llafwJKgt7Hvw
         zeqWn52o1fsiwmzoo4rrDQZv3h3IiFJnFO2iuBnkUsGA3ktjvtFHA3Jr6K2ZEcGMg8M1
         1di2ZTIAJ2yTB2V6zmlctv6zG6tcG5IvMF9RkWmI06r7tX+skZxDuVThBB0MSr3NZe3S
         B2+XxiOTA95Xk/3/+mlBZ2rpvQSIcAx9lD43yFxhcrOBvTesr5mE416XkZK5Fw1vsdLx
         5Q7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267891; x=1790872691;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LuPrvXBzY5FQ+f/5fzbveR9yF272P1V2+jsIcGJNdC0=;
        b=LeyLLR2XjulUBf2lp3sovd/39/SPeUjgWrw6JhM/Bp/9QCOWxWjB8lLrVZIPStAhNC
         ssIPm6POwKFczJ52QHGq0tCJxz4ZhJz5vMh9DQHHLvKC7wkpcfL2cMxSaP47DvmuwwaB
         xUzuplW1zVgeIvIXCZ+/R6vSEuljyrPOFAd+yTkyurf9fdZ0icWnoCB1HTjnnrvNoxz4
         xDUFTycYNIxXyautqvzFD07Z2bgqgX6+ZhNTOIiLy5SgxSU3n1J9FzQPNbNcO/hBCUxS
         gd17UP9vr9MsOZNJ+VRbxQ43lBfAR4qOZPDE/G7OKoF+T6V44aue5a5UURm6vIrMC0h1
         bHrA==
X-Forwarded-Encrypted: i=1; AKwUvBw7VzE8Sd6iUVa84zMr/KrfAUP7fo6WA7hbXQT17qQCehrnxh9lx5NxPR7oIjLirjLCPNBgoy9HGki2hlEfWCC7K0s=@vger.kernel.org
X-Gm-Message-State: AFuF++lAVxLWnAV+wR5lSaBZCT3DG5+ia9TEHUZSbVWmTC9+hZML+AZX
	uafO+A4pR63f1qzk/dZI6+kVnpm7iTXvqW0u53vHu9Rg0oRqZCvJqQd3Hpe1RQQ5pqE=
X-Gm-Gg: AYBFou1IscBzbTYXH7Jv6etVe+wN76PcjoBePwzdmvwJmEwmjY4CW3Js8ZhyUHpZzDl
	exVhpWbAYN5D9C5Xq4rhRgZA22oXj2XP9chitl0GfZseLgHZt1qYKLItIpa4xC0aKVySewHCqpc
	VSS+peOJvTu/gs+CviWMDQKYiaMSNYX9HOn+Op2S2PuRpQRVM8rUNR/V5eM+qRT5NmSyhFTUtIx
	9zf09JkVxf4/miRc5gdk2sAa1WtSQ5D4oYIe8wY6jp+Le9yqZ8GA8KTWAiNwtZW1ntlMilgN95N
	Bg5s8zfgHuPaglZZx+ba70P6Y+9+jk1+3AOp8zPhjQDUcYxji1tzQ/YAQkapF33Ab2Q8AGcVOdi
	lVokT+q0DaP23n/qW5E21hvBgb/srQHpYGG4AAQ00rkR4IqQ5spuF1MGCFaDTthhS0Twxcay7/N
	PWwmOQ+YgLOsnmJIJYuixUoXgIOBVxagFfdz3ydEUpxoBoKaNDzgUDj1gM/yxVJ2aqdPPB8wU3V
	7f8NAIznz1EX7SMZwR3usnSQW9Xv1nZMrTzLyPww0M/iLCFtcq2XyU=
X-Received: by 2002:ac8:5743:0:b0:530:d860:ffba with SMTP id d75a77b69052e-532fe9f05bamr29797891cf.6.1790267890993;
        Thu, 24 Sep 2026 09:38:10 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532eb32f6aasm45064551cf.16.2026.09.24.09.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:38:10 -0700 (PDT)
Date: Thu, 24 Sep 2026 12:38:08 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-rdma@vger.kernel.org, selinux@vger.kernel.org, linux-sound@vger.kernel.org, 
	bpf@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, fuse-devel@lists.linux.dev
Subject: Re: [PATCH v3 03/40] mm/vma: introduce and use
 vma_[flags_]can_merge()
Message-ID: <arVRqJZkql6sGunt@gourry-fedora-PF4VCD3F>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-3-4583d8a23bca@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-3-4583d8a23bca@kernel.org>

On Thu, Sep 17, 2026 at 05:22:12PM +0100, Lorenzo Stoakes (ARM) wrote:
> Replace the open-coded VMA_SPECIAL_FLAGS check in the VMA merge logic with
> two new functions vma_flags_can_merge() and vma_can_merge() and update the
> merge logic to use the former.
> 
> This abstracts the check and expresses it in terms of the desired behaviour
> rather than an arbitrary and confusing VMA flag.
> 
> This also lays the groundwork for making further improvements in VMA flag
> usage.
> 
> Also update the userland VMA tests to reflect the change.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

