Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FCC1D5175
	for <linux-trace-kernel@vger.kernel.org>; Sun,  2 Feb 2025 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738492937; cv=none; b=UwW8vAzMeJTlMWcERGnmiI43FGoVzHCfkKA6HWCAB1A0/Jp7fX4j7XS7cQgSFto3VEB2wleYU152rLQoAldIY0VgaOe7gZlL/5YHj2x5yARM5/c6WJPeSgit8dslrsHVFQGK8+2KVARXWsTrb3lQz9ZFil2nPDCyHP+q0pC4vJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738492937; c=relaxed/simple;
	bh=zkD5IRGZ/9bPr0CC0yAMX9lXRbXYUMweItegShby6uE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uV91ocHHBKNC677ezXmGdGswJc6kP353esyfDqFl4760w8vHVee+21cd/OyLjWhuXg1Iqq9Rhi98Wn8CnQZS3y4vnpZMig4ejP42D+NCNpScdpOU31zQNEEJuXWDZ1OjHnz09/K0UIBaikaWZ599+6vpWumu6Jw10foSD2gWxos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=060c/uhO; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="060c/uhO"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2162259a5dcso113154715ad.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 02 Feb 2025 02:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738492935; x=1739097735; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zkD5IRGZ/9bPr0CC0yAMX9lXRbXYUMweItegShby6uE=;
        b=060c/uhOWQe5m+YBtjrrvTg0GvS+5T80wFg8GPivsatUuNX7aAIdNafhJCWiC/kscN
         vqVaPOpfL7MXIvENQAUJvuRNPAVsbd7Xc6Z+ENDWvp7UHWBfBjv8xrHagxlOAkezhZg7
         XnAvXsabg8X3ewkqn0TiQggo7Z4711bbegY46M99RIleWnbuWNGvGfbPgZGMBi6/2fhy
         004zWP6X4PeBFUL0eM0k7yhadAnzhKg6TwzvPoKIZE9fThnjJIzQF4c4NHLiRC4wkOOE
         OAp3Ms+vAYj0Xgr55mwrVMYDPol9m9uF17KPjlB0D3fT2og8anadDC2nwro0Kg2AhM1a
         x3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738492935; x=1739097735;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zkD5IRGZ/9bPr0CC0yAMX9lXRbXYUMweItegShby6uE=;
        b=p3e2GsTf2JKaJALAXhQNP3oCSexWymiIEfagxE/QVjfV77lZuHZq0YgRfO3uV35bGK
         fmGZKwtmuZ4GGMhY9ccioOQ8ZKVKR1Aq0/ytxhqnps4GFnSLudhAn8DeHK/p/hNnt0it
         T34Ng2P7YLNM5FOBig67ynCrPFRzj4J45Ak5xdX4v2aeHvQ8T9rWthJGIE4LjU/wgpOZ
         9W93dTG6v/NpBJPEnzfdSURs2LcH2OtxQP2pjSyd4gN4iD0faXkLcdIjEWN60Pyo8uSO
         2hMrYE+D7sOBnCwtDULT4HzBY8Vs6AM5G3NcdkZoR9J9jRpIL3GTmbfDF36pGKsvtd5L
         Azpg==
X-Forwarded-Encrypted: i=1; AJvYcCWuTDmU9TvnQNWaAgmeXSZv8+hVQDsyOHsx50V3x2V4lEAvRo7MFhCUFEK3d8i7FcHMXdVKhILXHBASvzDRBVy64TQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YygL1WB6AnYw8qNuU1c6XnxO983QeygjuzWLp7/BBYs08+7Y87x
	BC7oiYQANR6x/V7rfQY5AvTXHBbIzou+KOWXbDD9Qy6FrJbfhCC01tzX5/y100eNvYDdLQ==
X-Google-Smtp-Source: AGHT+IFo+c59bClMb3w3IGnlN130wN7y6oOR1HcCzkELMUY8CVZ2GcCuOdp4NbrOfZUYhOCT0CSDVHhP
X-Received: from pgtq4.prod.google.com ([2002:a65:6844:0:b0:a87:a3b9:db3d])
 (user=keyz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c941:b0:216:25a2:2ebe
 with SMTP id d9443c01a7336-21dd7c65844mr278809895ad.19.1738492935252; Sun, 02
 Feb 2025 02:42:15 -0800 (PST)
Date: Sun,  2 Feb 2025 18:42:11 +0800
In-Reply-To: <7hy0ysi4pf.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <7hy0ysi4pf.fsf@baylibre.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250202104211.2764016-1-keyz@google.com>
Subject: Re: [PATCH v3] cpuidle: psci: Add trace for PSCI domain idle
From: Keita Morisaki <keyz@google.com>
To: khilman@kernel.org
Cc: aarontian@google.com, daniel.lezcano@linaro.org, keyz@google.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, lpieralisi@kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rafael@kernel.org, 
	rostedt@goodmis.org, sudeep.holla@arm.com, yimingtseng@google.com
Content-Type: text/plain; charset="UTF-8"

> Tested-by: Kevin Hilman <khilman@baylibre.com>
>
> I've been using some local trace_printk() to do exactly this, so I fully
> support having some official tracepoints here.
>
> For my local hacks, I was trackin the state index as well as the state
> value since for quick debug, I find the index to more human readable
> than the state value, which I have to compare with the
> arm,psci-suspend-pararm from the DT.
>
> Anyways, thanks for submitting this!
>
> Kevin

Thank you so much for the endorsement.
Showing the index sounds like a good idea, although it should be done in a
different layer (probably in the GenPD governor or cpuidle-psci driver?) because
idx here should be the different index from the one we're looking for.
I will keep my patch as it is just for now. Thank you for the idea!
