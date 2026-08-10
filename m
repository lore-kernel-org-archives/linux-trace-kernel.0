Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCD12FFF90
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Aug 2026 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366631; cv=none; b=tiMFeNHL711lq7O47/Vw0ys1JoAubVrJhj49LMTyowfYqLR/ix/OUabJUoRrJCG8eOLbMfiDeIwN7w8iAtONzMkOq5nU8YarxXiO2wQUlHuOly27qvqge8FBWrtK8bmFkcIBnkMDSA9mSVrrCHsdy74evnNSzAQbCWsOuRIe76o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366631; c=relaxed/simple;
	bh=823PHjELYM5yHRSjRUupdLUTjWYmkbk2XUtNqLAcUnQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sgNNKE15ohVQpleBRhZm4INYVmDyPpglMoj5T3qz/Iw4rtd8puunj7rxp/jHyMfX3V7IehSYZTfXxJMw0qw62cWrH7gcZ/QKWlX6mgoavc0uKidTxvR7lRguChPxsMDfd8Vowa8SORzrSOcxs/bu0pH55gkBmO/jTUkC+BJvIhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cOmRHtfT; arc=none smtp.client-ip=209.85.208.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cOmRHtfT"
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6983e384c66so1377464a12.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Aug 2026 05:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786366627; x=1786971427; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=syu44qeUMP5b7+tQq1BgvSHIvS20NmuVx0tn+nwZpnE=;
        b=cOmRHtfTvE2YvfD2nw0m7R2vMR71GETGBt0bXUj4AEErqcLELp3/TiqX0LnZA4QLHQ
         eoXgO3ewXe9aTOKxfPE8oaE4h2HJddjiSXFp8l0CLz99/OwLN8WkFYm8LZopxVdrr9jq
         bSzTCIu8rE7msObyzd/4b56nE/T9KyHhmgpaif9j/6iKhRU84/MFP/Iw5WvggPM+E8X1
         5aoDbUrU2r9kJ7EhHmeAEQCC1/1RW8jAW8p+DUnE+784Z9Y89FwZpeCQg//CfVAFK47R
         bnEdasCDVNSQXGqUBA7MYnq05UhX7PZE3NHWLdt3nAk4R2T0owXUnDPaQ5bRSEo9XPOf
         r9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786366627; x=1786971427;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=syu44qeUMP5b7+tQq1BgvSHIvS20NmuVx0tn+nwZpnE=;
        b=KmBEbbo6g82Aw6wwVl0slEQbbtIshfapCxCeQgC2nIyXqP40A6/WGPAD9wRHCEU5KJ
         tyErXQFeg0GjuiMgHmo7++ch/t4y1vmL86WU9hZO18TFicSMxyGYhrpYWH4HAENpXRUD
         yk4uzrVFkoAbaT9chFWgDD3CPEocqSc+NJqgMx/RaBquu6j3iHp71fnV+N/U7yx1jQH5
         Mk/wUWwYZdFN+t+R95fgImw+HP8xYp3sL7pjJ8RM5gr3t/GoRfkWNtfG5X67FtKDwful
         s+Q0PSo5aIz7rz99paimxYhAdb/uo5tq5Ne63EaJnNvsMXmfE9PxwkKA+qBeqOrYA3pQ
         MrIw==
X-Forwarded-Encrypted: i=1; AHgh+RpYMmqC6t82EHbX1ZUVWJdiNBkIQ0azx2i381SAosyPhznvZGIlfJdGLhcj65jXCilSp1uvXHeInZDMuooy6bQ03wk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5OIBbmwCd/LS8lJ/EYkWSfG3thfU+1LVMxlrpcKo0l1OlQT09
	0K4pmV5oX9eFKxxKzi930VV6RNpTgSy8kEO1dM/kYfIwt166hIjPw6sNKg+3PRux7KjbMaSxzXf
	1H9vY9CAsolMnYjeoMzRkMA==
X-Received: from edty15.prod.google.com ([2002:aa7:cccf:0:b0:6a0:dd2b:3fec])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:5058:b0:6a0:9a26:976b with SMTP id 4fb4d7f45d1cf-6a1f25c5b88mr9046989a12.8.1786366627151;
 Mon, 10 Aug 2026 05:57:07 -0700 (PDT)
Date: Mon, 10 Aug 2026 13:56:27 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260810125633.3344684-1-vdonnefort@google.com>
Subject: [PATCH 0/6] ring-buffer: Fixes for subbuf resizing and persistent buffers
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

This series addresses multiple issues discovered with the dynamic ring
buffer resizing.

Changelog:

v3:

  - Drop first 3 patches (Rebased on 7.2-rc7)
  - Add a patch to align "nr_pages" to unsigned int
  - Add a patch to remove useless trace_buffer::cpus
  - Add unsigned long cast for rb_subbuf_size()
  - subbuf_order fix for rb_free_cpu_buffer() (Sashiko)
  - Use __always_inline just like the other accessors for the hot-path.

v2 (https://lore.kernel.org/all/20260806211306.3704194-1-vdonnefort@google.com/):

  - Prevent resizing of the persistent ring buffer
  - Add missing bpage::order init
  - Rework subbuf_size/subbuf_order (Sashiko)
  - Remove ring_buffer_per_cpu::mapped
  - Dynamically calculate trace_buffer::max_data_size

v1 (https://lore.kernel.org/all/20260805153225.2096152-1-vdonnefort@google.com/

Vincent Donnefort (6):
  ring-buffer: Fix subbuf resize concurrency
  ring-buffer: Dynamically calculate max_data_size
  ring-buffer: Free cpu_buffer->free_page with subbuf_order
  ring-buffer: Remove trace_buffer::cpus
  ring-buffer: Remove ring_buffer_per_cpu::mapped
  ring-buffer: Make nr_pages unsigned int

 kernel/trace/ring_buffer.c | 259 +++++++++++++++++++------------------
 1 file changed, 136 insertions(+), 123 deletions(-)


base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
-- 
2.55.0.654.g21b8a5bc05-goog

