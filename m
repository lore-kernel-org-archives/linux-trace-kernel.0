Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C253E17BCE
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Mar 2025 00:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741568027; cv=none; b=ZKZFy+2lI+U+UpDQc9+Jp49kEFvHMGLJvr9OP4gid2grZIRJeX/RkwaGXWuiOFckTsZ1oqItZr0U4oKMaQArRLwFN2ZNRnYcmTBErhE6KXCKB4DjX7PDr8FT2Uj/qUH2fZIiTIb5PActnmHMuI270XT53/P9+1dTUJyMh32ZYjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741568027; c=relaxed/simple;
	bh=BIK/8I2pjoGPw5VZt+Y5/DpLbcA23EijycR6oVIPUPs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=G3QC4a6Nb0II4q4yw5pR13VGbXyP88p02tmiNT0MLDyoy5l8famr4fF/7K0c2aM9WsaAod1Wkk/B4hasFGg0vNTTm/bFUMy3YFztbBCCi7rswQBr8kXoPmjooUg8ddWvoCY2vVz1Ue2agBhADW8H6OnUhXXSFyGaQeJBiaT+i78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rHmWb0GL; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rHmWb0GL"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-225489a0ae6so149375ad.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 09 Mar 2025 17:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741568025; x=1742172825; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U1Kft0nvE8zLlsCQF0ZS1U16R5/zABLbJTZ1Ux7p5e4=;
        b=rHmWb0GLOFLzT35O5h0pOvea9HyykK5hMaV4FKfU71tL0ZplDCKHw8souQUuWB3I1f
         6585kqT+pdDONDYgzg0kqjQ0neijZ3ZyXN0RMr1QohfZFpQpwOXTLrVHZsgx7bmpQd8+
         pDbUwtQj/k+kilAQ0uo8TGWEgO3KgOSHuBZ/OpqSHUXL6Yp8iKPdclsRVmhsSD0cEV3R
         bbbYYgXnf9z3uGqjJk3g9lAzPI+YBBo8vTi8yA2GDv3ceRyehTPKe7eQVfnJ4J5/JCno
         8HyOTjK/KxhRnKYqXmDiGHl2kAo0Y6+3gLBBA5CXToSPGiZdAhfIMmzfxTu06rQVRU73
         Ec0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741568025; x=1742172825;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U1Kft0nvE8zLlsCQF0ZS1U16R5/zABLbJTZ1Ux7p5e4=;
        b=sS+ilTRlUyV3Jgfthdha4UgL/j7JhOl4l1Jzd8WgSX5RqwYLkf34lFNIRaO5QAM3qd
         Y6sicC/4vqtYBBIbCoVcRGtc+YAIJ6REZl8ADbW6TviOwzb07ZJrd83YPMm7m6NWLG/d
         ia34L6xkOMO7mVGmqsF5CaXyyzPxmS0+grx470kI6ZL57MaZxmmy+VNaBW5r2T57Ey6n
         J9ew/cH8IcG0Wr8dAdNbzWVOD8z2I6oxuEWoyWGoMy3VA4jEVnzyUfIGq/SkUQBz42+8
         RCUzY5ElXDKzYcoXHxd/y/AhvrVWYe2xuqfgcDliunRJi7H7FJnbkiYP9YZ3zhRu8wJe
         yyiw==
X-Forwarded-Encrypted: i=1; AJvYcCUFMZUFnBKdHMk0uKMMSqFMVdOnUdf0JUVcwWZ6Lrl3B/2XIyNMzwNmQFV/b9SWiSHT3PWdypB2VHuvZ6w6FGKii6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywaal0t/AElEnm6Ro+PVwgzIrjvP1W8SA0/515Fn8wyeF+SHIuZ
	VPPizOj7IWxjdB/7BqvJ+LOHnTSoh61YNdo0nxpJTurlxLkmWLYBMCas7n7bHU+oKBJY8XWz5d2
	8og==
X-Gm-Gg: ASbGncufWD68f9WKp72FHTDXGWR/8mXjV0DGrSOo4WWQBVxDIJWbmk60FV1BNHrMEPr
	NMNmGhYrxOJWkoIhue9pfGhHc0ONPD3xr0KRT87XsEYLS/DlQJ/h/b5yuRaF5vn2nrynUO5dogS
	fju6r+GppxbNYpL+F2w1QRh9wrAHnPsbu6S5mOqnHDPQyw6LPxgieuf9qhCVEsbBbSt8dF7g3Hj
	SKj1o6dQl0QNiqrnoz8g0MAKflkdPjZakOcJxDBPgdUPc7yS22VQnARVbzUluOH+wI5cVwKzxS/
	60nEBRiztYUu3fplYxkVO1ZmcCmbsn2ZBx0dnZJfvFOFGrMtMRqs2qijV7pTEwesp5IrwRehqJA
	tnRDnwgupwl9lnALm8oAFZ2iZCa1BMrAn/swpSIvUAmaJYKn2fA==
X-Google-Smtp-Source: AGHT+IFp/vCjMy04XPyaBQoM6EiWwSiT173cXoiRYLIUYkyPcOWLuSFg1lIFXhE6+Lt2OAO3lo179Q==
X-Received: by 2002:a17:903:41ca:b0:21d:dd8f:6e01 with SMTP id d9443c01a7336-225477853e3mr2193915ad.5.1741568024812;
        Sun, 09 Mar 2025 17:53:44 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:ee55:e440:a203:909f] ([2a00:79e0:2eb0:8:ee55:e440:a203:909f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7737a5sm8619525a91.13.2025.03.09.17.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 17:53:43 -0700 (PDT)
Date: Sun, 9 Mar 2025 17:53:42 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Martin Liu <liumartin@google.com>
cc: Steven Rostedt <rostedt@goodmis.org>, 
    Masami Hiramatsu <mhiramat@kernel.org>, 
    Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
    Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
    linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] mm/page_alloc: Add trace event for per-zone
 watermark setup
In-Reply-To: <20250308034606.2036033-2-liumartin@google.com>
Message-ID: <31e46f74-c6eb-58d9-bad6-518d96de7d96@google.com>
References: <20250308034606.2036033-1-liumartin@google.com> <20250308034606.2036033-2-liumartin@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 8 Mar 2025, Martin Liu wrote:

> This commit introduces the `mm_setup_per_zone_wmarks` trace event,
> which provides detailed insights into the kernel's per-zone watermark
> configuration, offering precise timing and the ability to correlate
> watermark changes with specific kernel events.
> 
> While `/proc/zoneinfo` provides some information about zone watermarks,
> this trace event offers:
> 
> 1. The ability to link watermark changes to specific kernel events and
> logic.
> 
> 2. The ability to capture rapid or short-lived changes in watermarks
> that may be missed by user-space polling
> 
> 3.  Diagnosing unexpected kswapd activity or excessive direct reclaim
> triggered by rapidly changing watermarks.
> 
> Signed-off-by: Martin Liu <liumartin@google.com>

Acked-by: David Rientjes <rientjes@google.com>
