Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34CB3D3D1B
	for <linux-trace-kernel@vger.kernel.org>; Sun, 23 Aug 2026 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787490066; cv=pass; b=lyo3BdvnQEPj5YhqZbRr2DBIfjoddIK0tEANhtDJll6mN6Gi6IC5Ic7UQ02Plx2Jn2WhMtX+IpOD+LJavJz+y0S7YZnA7+YF1ecJ1WivzOudd7FKoCY/R141PHxDk6j98ZiD5ezo0QaRTeQo3k4bkny+Cfqd4EdY1qtSm29Vcow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787490066; c=relaxed/simple;
	bh=O9vqDCNyl1ldG7SeHQIKR21U6TYJFN/g7wDlqKknSzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhDXGtegd9Cn1YOq2zu25UF1pAIWa7CmCJ1Wxdx2K89mclQ2M1nPuTpkk88jrCm4nEG4epeO6xv9onyX+Zza91eNgPmRZZUDnhcwqcW8XDEKQOD/1GBhUFAt+nPUjpYJ7VyL6YLD6VoYaColvJbqe24E1PSO8MCywn3Kf9J35NE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k38yx2/I; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k38yx2/I"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-836cde02992so31463977b3.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 23 Aug 2026 06:01:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787490062; cv=none;
        d=google.com; s=arc-20260327;
        b=SkAh2SuXvTXKQo+RICtBK1GXbTAtiMZ4SySdnlZrrqGaibFPSzL8vKoiywp36W8xGu
         UKpqzZ2DKhj8lwq1hzNld1GFztRfyD6ZZYlgsOUvF0kRK3MhdhwkP7RU7WbFO1eUXhO1
         jYRPOKo5K7EBKDJFxDii43anBCoUuG2HpYsS8PIfM5c3RjvlKveOTrboG0xNgFFVO/gs
         iKNNRfCIXwCCRlqFCOOoxI96p1f/fT/not9TQPjHDXZJ9nj75oBbg+IANBgoS2r/ivcF
         Haa/8jggHvERSF8/wy8hksNHu1dJS/DklnjJPwGjdPz+y8flu1itYMyYz9k3GnUFr9EA
         FJ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=O9vqDCNyl1ldG7SeHQIKR21U6TYJFN/g7wDlqKknSzk=;
        fh=jvBiXGkkmDBoUnBsr3Hqbdp585yFGfQn1ZAgetjk42A=;
        b=HpM0jp6qQGNz+9fPPTe0LyS2IXZl701310s/QTtWHCXPXAK9kpOidyiHv4UQBdhAjM
         7U/7vgaRFKACH6RA5AjxBgl89CnzQkbKmH/bT40ket7u1dqlDFJ3IiGKjq25V+SlPitD
         FFhcY2sgYcxaXRebqrKxSUVdTUze2ioHDxSjRBXPBUBdBcPs7YKE6sK0u3ifjYnUR20K
         GBmL58pBnwlI5IgonWVVSWj9wQNoDY6tMAuHaPgkxks3e/kOQA47KLt3Gv7wVXNzSYh4
         hZ/vNg16epiaiY2tW5uI6A2NPnzh/2O1BOEsoUD7jWprhZA4ezyfPkGm+xAf1gGxyP3k
         F7Dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787490062; x=1788094862; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O9vqDCNyl1ldG7SeHQIKR21U6TYJFN/g7wDlqKknSzk=;
        b=k38yx2/IMBewZ5wPeY3wfArb828ZqSjceF37/VrS5Jhm+rXjZCoaZj1JHnVNF9Hxyp
         LtpfZXrV98VUQkK3TiWQUIOITohio6QLOWThlVRwdRUoZssb/1ODZKNEtgko7iQkZtP5
         0zF0cfDQfnUR2oQXbojj14e/mzFzAhy7D85twScxZlvwrQPrD/Xz+l2jycfbgDe0z7t6
         bK+9R562wiX/AQEB3ZqyI3k5tQ9DzQRgElGQ/VHdulr7KezzAIrRPvIE13rWD7gQ9p/N
         ORmLevWXRIPJmeQ0u5/zYPEriO3roaW6CLIb2bDtprUDlmxbr91djCOqE2FCnn2+w5ag
         qDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787490062; x=1788094862;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=O9vqDCNyl1ldG7SeHQIKR21U6TYJFN/g7wDlqKknSzk=;
        b=EPyImnkRY0aUu436+UDsQspTSfVqXMd85pzFGPsCUl+PCssf1vV+N2tmNg6tyEZyTe
         4YvqR2KbHHh5ReCIic5XCEmxbCdjqXkMpRZ5SWo+IS/NpY/A2GWoFSNI4YrlYHbAX+HJ
         lcQrkDr/z07hEuqg54xtyE+ixo7g1zAxC2gDY6lkSUOopNcIxZ7eOOgsrVsswwHisQii
         58YZp7isqtS82xK9TU0wgfFIgG33/goqowNmQLsBb7CQ9+/mUusXj4ESF3QxW19BPuBx
         4DNUJ/jqscTeUpOO4br7VK3stGq6F315lc5AzjqcMTTDBgj1tLJ4ILzIXVOrciN0oVsa
         9zjQ==
X-Forwarded-Encrypted: i=1; AHgh+RrH7c24mb9etmdz4W+c7dF/VKQCVHZ4tUxmgxHTdXDaOTcswcd93nTRqE8LV2OCLx88K9TaujfxNkUSFgQHQZBK8qQ=@vger.kernel.org
X-Gm-Message-State: AFuF++ksgO0YhYnJuHFq3aLmcJHsMtiWiELgwO3OAm0SCO0nn6crzATd
	31s0IkXWmt3zV7rA6JXH0/YCgwu7czpGwQyRlVtWjKfRVMA/kx3ugi9drln8KbJoN7by/7ASGLW
	hhG+u4DqaCtL1dV6VcRYM8WmtmFSv3mQ=
X-Gm-Gg: AR+sD13wbNYO2KQOWYTg4+itTqWZzNp/xP16U2OCo9BX2J0VJosx0IJM50y5nL++JW5
	Tw2gcmm0gr6XP1g+gLHg3vmhPTkVDDtFc1Z8zZ9QUFr1aW9uzuasJ8hMkCQ0gmeH3/avyTjTQRi
	47p0Y8hAb0rg+zauDVx+J4f/NJ4hFYpY+PcVJXOfBWbAX7LNKD+rF3yytx8dnzHvX7pB6FtaRYQ
	Ij58WN/4XE/Uahc/NCo99LUaH1+/gmi9ZnLkNPaxWCXJeWfM1VBK7G90NVOhe400/hvSg8t0j1S
	nUKRUtk+dBM8RRrckWHhcV7jruIoieiPvTAluEgNRa5Uag==
X-Received: by 2002:a05:690c:d83:b0:80c:cad:c4e5 with SMTP id
 00721157ae682-849f7ff26aemr72556687b3.30.1787490062386; Sun, 23 Aug 2026
 06:01:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822054620.452262-1-ming.jvle@gmail.com> <20260822060014.AD2681F000E9@smtp.kernel.org>
 <20260823210208.25e21677ac0c691037d7ef24@kernel.org>
In-Reply-To: <20260823210208.25e21677ac0c691037d7ef24@kernel.org>
From: Keke Ming <ming.jvle@gmail.com>
Date: Sun, 23 Aug 2026 21:00:51 +0800
X-Gm-Features: AcwNN1XIQy6WlLi80y3ZyXLQhI2zYm0ez-nOfVD-Q_nScJLYDeV9eVrRCcMmrdc
Message-ID: <CABbwK514OkuOk4E97a_45BkSKU35nsMAV0U1YqmoYOXEhysqKw@mail.gmail.com>
Subject: Re: [PATCH] uprobes: Free utask on dup_return_instance() failure
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks, agreed.

> Hmm, this seems another bug here.

I chose method 2 (clearing ri->extra_consumers when dup_return_instance())
in this patch set. Please let me know if you prefer the first approach instead.
