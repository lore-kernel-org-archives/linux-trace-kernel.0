Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583654;
	b=Kxz3nwYk8EbWjakMS+HiAXZ/pk6ERo8EdnfwP7UQAXxaRY/7FMOve2hTpoi9y9XSStrR
	 yBmj9vmw1TYVCXz5DkI36VgNmNIfFG36TyfQ1vMmdh/1x9LN9viKuu/Ln2AeAqx0i/vBF
	 ot0shTPnaADWpa+rQ4ScoXztpbUUxWL/S2Wsmh4aw4bwBrRmB+LNEXsP9XhSkaZgFrGOO
	 8L8YlGSdmubSHQyvg6V7nQwiszv+p7B2GTeyczT/AheZ7InO0ljrQGKCUgFxVm632NHD0
	 UaPGvSm41QNVhV34B9JU6KaS9WHfE54n8dhI4lmBiRgkSJP9OFdSlcJJZ7urpR18OZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583654;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ufj3bjLDpGq20+8LFXkkxCdAXIxC5JGd/uesP7CXbSQ=;
	b=uNkyxAeSrXfjqNrx1QF4VI+pCDbLkLnVLvWarlb4dQFgd/bMTL0aXPiu5TFASjC+IpSm
	 gGFNKFaRzNlsqKOpbWcUJ0u22UCUtxuwLeQWQhQHOEQ8Hc/F1OEYgMIXa9zvYy5h+NsOV
	 uuvZtuZHBR6feqjU7srr4mTfvZ1UGBM4l+KEfaDW65H+4+CzZk4L+GMcyvp4xo/cv9kvF
	 zXU6V5yBhV1l5Yo3E1Z9Kt6fIw29b/c/vnRz67aU0FEv5e6y4/+1VnKsh5EI64VQwWzgn
	 It4Q+eJmmO57IC50L5Runjlaaf7FT5h99NhTmv8BaF8jzxXwXweSlcEiYst0iZxh5sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pp3EJHp1;
	arc=none smtp.remote-ip=209.85.218.70
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A1F606A323
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 15:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08A1F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pp3EJHp1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c293e604f0eso41006866b.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 07:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794583651; x=1795188451; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ufj3bjLDpGq20+8LFXkkxCdAXIxC5JGd/uesP7CXbSQ=;
        b=pp3EJHp1ttZ0m+dK7vaMjimBBXm2TQHLlVACJtfuO8Qp1b9UI2HpixPrU7LNr3M4kS
         GHyHkPYJBftBWF+R/nsrHtml0rnVVY9Flq2FhRwsUI7J0Ota20FWFnmXhR1xjblUv+/3
         CnnRS5unlW0pBDquMiZwieZRutJ8EvimuuMqo2RdYAIDIMacMourFb3Vb/Awn9WD6dIS
         Y8e8tjnBf8XMT7BIVAMfxHXuqYsoVYnIJq5GFPDhoZQPKrhK63TnmJVQ1jvftevba2+J
         NyPfVG1ClpLk+97wZ8s18Y9K3zO7jp0h4U85x+JEC15/jMR99/6SNYtjKRV07f0Ym/KR
         J3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794583651; x=1795188451;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ufj3bjLDpGq20+8LFXkkxCdAXIxC5JGd/uesP7CXbSQ=;
        b=DkF0ZYP4sWY/xklVIAj+q3U4hKmqCRgfqPRPJpUJ9yNk4TNgg4B40oG7RvQlBZI8bM
         5dR6rU93zTYl3OMNwp6zLRUXPaS+R4GJ7rVKiTz7bm19RZMNHr9kHZprj9C6PuamOMgZ
         ZZo0E1r/s0lRsL0XmZP6npVqjGNeh5QYTq3Oe6oVf+y0fHguM7WZr1G9qNMK0NUTa2mi
         EEha3B14v6UoVNQUrg6sYukvTTKb/Ip5spmDJUre8EIohb3oWy7mcdtveBIbq2wkCnQq
         Z8jzh5cBYS5Zos6WBm9H8JAwcgLzHQ8Uhi/fECf525SJlSuJHo8EdiHq9n4pAfp27EZK
         m7NA==
X-Forwarded-Encrypted: i=1; AL+hErFDincArzJ5XRucm7YtMDgZ/jUpEGn2r2z9FIK4KQ6onIqMcrvVMyQd4oie2GhZ8CHvnEpKS3avNpN87vnEnNwIFNc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9D9rBhB9aGiY8HrZCC6SRsnYpxFwoIAPAf3OZOrzJngbCQPdmz
	3gWbDgdzsM3MIQ2PS1KGxNzdcGyYXVoq84x8iAwHS6MRXo1ZqxhefrDAWstK20RugitT0rpgsgB
	b22KdKrrj2Ta8fn1tLEMpUg==
X-Received: from ejbkh10.prod.google.com ([2002:a17:906:f80a:b0:c50:7d13:f19a])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:9485:b0:c40:b477:dfa0 with SMTP id a640c23a62f3a-c509637afb4mr264673666b.18.1794583650971;
 Fri, 13 Nov 2026 07:27:30 -0800 (PST)
Date: Fri, 13 Nov 2026 15:27:09 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261113152729.837429-1-vdonnefort@google.com>
Subject: [PATCH v1 0/4] ring-buffer: Fix remote reader page swap and memory ordering
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, bgrzesik@google.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Bart=C5=82omiej reported a remote tracing issue on Android kernel branches.
Although that code differs from mainline, investigating the report
showed that upstream has the same underlying shortfalls:

1. Potential corruption of a simple ring buffer because it does not
   prevent swapping the reader page with the head when the reader page
   is already the tail page (nor order the page::commit reset before
   updating tail_page).

2. Potential failure of rb_advance_reader() because
   __rb_get_reader_page_from_remote() checks rb_num_of_entries() before
   checking the reader page commit via rb_page_size(), and lacks memory
   barriers ordering page::commit and meta::entries.

While at it, order page::commit with page::data and page::time_stamp
(patch 3) and add the missing pages_read increment on remote reader page
swaps (patch 4).

Vincent Donnefort (4):
  ring-buffer: Skip remote reader page swap when on tail
  ring-buffer: Check remote reader page commit before meta entries
  ring-buffer: Order remote page commit with data and timestamp
  ring-buffer: Increment pages_read on remote ring buffer page swap

 kernel/trace/ring_buffer.c        | 46 +++++++++++++++++++++----------
 kernel/trace/simple_ring_buffer.c | 26 ++++++++++++++++-
 2 files changed, 57 insertions(+), 15 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
--=20
2.56.0.611.g1030f0b940-goog

