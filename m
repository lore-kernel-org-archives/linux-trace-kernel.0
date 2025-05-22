Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB99A19F461
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 May 2025 16:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747930073; cv=none; b=QnBQ0cgez+FofDQ6S3Ty7bw4ETWhQRnKA8oTyqhJUFUlewZq9UO3gaur5dKxpMaZCvl+CWMjCTpya0/ChLskeauElWhw38HH4sw7OIu4eRe0h9UbeNOxWtb13URqGAspJFgeSZvW+clO1aa3gKXixZ+65IYAiCsazlR0zZMXkFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747930073; c=relaxed/simple;
	bh=G8Mv8bQiaDJa5SmClYhERN31MEnqOBxSaleO48WeUSw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=S5bjbsJLbFfJb2iu18Mj5P0FZbna/srfgOO61zGcY/gK2z3qhhyLoBE9NjLJF2weBq8Qc2FJHiZJGelJDBkGn9ot8mqwhlCwltZgte/kz5GFZZY99WkQEcSIJwDZsx1ufmCPMN4gNS8iYe0I+mnFDu6hfoQB/gu3wMaoDuBtRNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=In63vS5y; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="In63vS5y"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-86a052d7897so539444839f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 22 May 2025 09:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747930071; x=1748534871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0F+3sCLS0bt8X7P5AVbJqQjk87UjImEe9PD0EgmZH0=;
        b=In63vS5yi1yBruF6/7ppKhAMk0ufMqn1C4oO9lk7jjIxCScnYkDTIoLFj8f6F0L11o
         wjkvnr7UJh83oJRuMHuAsiBhCe2AIvV1Jtf+3G37pLrEJwbygiwn0v5ZWHjxVGwqBLZr
         TyGzn0SpAW7hD71GVQ6iaRR1esAlbGhPMY1NdqgFz3RcIohK60Bo5/wh0phcUdYRv9aA
         6Xn8mlYrU63zEU+kNJtCi1J5N+txC3BSerZVAMa8SACGm4RW771EEOxjUuLm9ErdrrZl
         mrnRh7+XRnBjBS9TEVrBVBxtc16RFa6E9mEwTRxAvWY6lRkMdDSLukdVtqQmclQhCUa0
         Oa4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747930071; x=1748534871;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0F+3sCLS0bt8X7P5AVbJqQjk87UjImEe9PD0EgmZH0=;
        b=ZwIW0qVmhNAcsmHbixTIBAOZY1nTpv1jo4toD8H7K3uumXNh3MVM+/fq/l4c637P9B
         KVLLFwqu+yk1n0ptMiiY7CxptGzimzrcCNbgpzOIersPfduq1yy/dC9Octhvl2xageGU
         hHuTVO9c7FTrrMonuH7zgUUnamDlqsvMEn45duGleu4cy6MIExq54PonIuQLvrgU0/2Q
         KiNfoDVgRber0gLTvBN73om1yJWFVxlX/LQE26DeJN4IyKK3R3Hc4Gh8iSt6Oi31KHX7
         DmT2s2bzCsL4pPGWmn7kW8WP6L2IkzInxW9V7ii6SRtgA9LuU2CYaMEQSUjc2qDZSWPX
         pslg==
X-Forwarded-Encrypted: i=1; AJvYcCX562YPNNdOsdG1b2gTtrOXAfkcd5dAFPXSjHcpFgSZyybudil0F3p1YWZsLtgjH/iN3Wz1DElVAnbyJ4vxq7FZvRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIm0eOUJXmlrti7RIO3cdnWDPpbnm4KGRCKEy9gKa3dtO2tj0i
	y/XOgpIkdXeDihZTwsY5Ll4IGVqkW3txRYZn8HG3oeaHgCSTI+WXBn4uvcqfmMS0G8c=
X-Gm-Gg: ASbGncuc3zqd0LEXDX1eBUy3i2r3lAxNEwRWtytZdzXyHKIyXliQNqAteIxJ5VUEQVo
	dwnAXZWJEsGeyaRvtpLl8jBd4uVrlfTN1kDMEDpp2QfrQTWG+B5VmR8pEnC8uPaSZkuiUv/+uDm
	KPo0/FnR+SZVp/PIkZqUIKN2YhdpdU+tZo7Ab4OyPRyjR+SDMyo+DESAHndQm5zhQ7Lqo57sUJ2
	NNmCo6rjWFcwj5bpArocv2GsOk48hETsnt7J+pu/8dTLmilWHd+p9ABnsNfzZz0HHY18wM38WLX
	osUgyVSKjhcV30CLdtE3otE8hQXN0z3/qF8spaZQ+w==
X-Google-Smtp-Source: AGHT+IEmmT09lNxt6NVOQQPJ4Ie1OiNcfqxW+xqlr7SYGEsMkYruK2UASM5a6xpf1CgsBSaRB00c5g==
X-Received: by 2002:a05:6602:19c4:b0:86a:25d5:2dbe with SMTP id ca18e2360f4ac-86a25d52e54mr2466836239f.4.1747930070711;
        Thu, 22 May 2025 09:07:50 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-86a235e377csm305088639f.17.2025.05.22.09.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 09:07:49 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Pavel Begunkov <asml.silence@gmail.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org
In-Reply-To: <20250522150451.2385652-1-csander@purestorage.com>
References: <20250522150451.2385652-1-csander@purestorage.com>
Subject: Re: [PATCH] trace/io_uring: fix io_uring_local_work_run ctx
 documentation
Message-Id: <174793006954.1178150.14780914506137939683.b4-ty@kernel.dk>
Date: Thu, 22 May 2025 10:07:49 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Thu, 22 May 2025 09:04:50 -0600, Caleb Sander Mateos wrote:
> The comment for the tracepoint io_uring_local_work_run refers to a field
> "tctx" and a type "io_uring_ctx", neither of which exist. "tctx" looks
> to mean "ctx" and "io_uring_ctx" should be "io_ring_ctx".
> 
> 

Applied, thanks!

[1/1] trace/io_uring: fix io_uring_local_work_run ctx documentation
      commit: 28be240c763a44932bfe573f09e145d182e52609

Best regards,
-- 
Jens Axboe



