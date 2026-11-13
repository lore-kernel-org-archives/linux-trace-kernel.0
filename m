Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583657;
	b=WoEurdJlUHZDzN8Q/n3zPnh6Ic0iDiDpD3LT1LmUP2o6hPXg2Y/EfbPlhKlPiNSmPlVl
	 pklkDwCMb1FrHUgbL/xwSgsyswCpW9b1uS6IfVYMD7jiCamUJCP+5PEjirj0gziR9GPAn
	 7FyKLZ7IIrrydHCLsqxp+QHOMYNw/Xf1YrYig53ju5VAL444aHuA3xIuoEC5oGHnt9dmB
	 7k5v50/AilEhr1fjYAsG8fOdi5BlEKyGnC6wE4PKYs4d9I2M3xLDmVGEimVMntsMDnMn0
	 x44eRdVGQldUmIk/O5bH85VNtZvdIuArLTqZuH3Sn8XZgOyfR8GePpGoE4KFvNJ9SrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=FO88jd7JN6r4cNWqmQOa06AmPT79EvpBEfyhLQB3b0Q=;
	b=bgAj+VgI4xui30yGpN1VaklgJS1wPZ72CGCYx0p34ikESgg31Dq+q4SsMvt/Eh5PaHeP
	 LyIfhTld57MFvhSW7zK1FILgod2KaDfT+tVNbEZ2WplA0VET2aUD37HKGb4CEva2ihYAM
	 96kJ0wbao9St/R8gylziyzwSxx88vxRJybULu21+k8ulDLZQ0u5d5d3clEeOWRDGagSu2
	 NPHNN5r9LSt9KcxdlYSmfgFFxvvpMhDLh/iBy+wBfkbqYMQY9dHyJW6PT6ziLAussuDl7
	 eB5Z3Ak2yJaMg0baY72bp7PITrRHJvTibuXBGk8X3gLkJuJLXjJzlpfdQgDtbKdLZAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PcrZlBQu;
	arc=none smtp.remote-ip=209.85.221.71
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB08606A8AD
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 15:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FB08606A8AD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PcrZlBQu
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4916bd6e3baso1027435f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 07:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794583656; x=1795188456; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FO88jd7JN6r4cNWqmQOa06AmPT79EvpBEfyhLQB3b0Q=;
        b=PcrZlBQuxK13YnpNxig77ucJSRNONnlD2i+0hJt+iom3id1f9v5yBLIwZBF4MZQEma
         HWnDtuJZC2DPYUEwRgtmoJBQexndmBrfPwxrG3CVU6RGitWOqToDqK18YzAJ6IxBI5LM
         HGuzo7fdMspDDpKFVrNIZ6d9CThvqA4OVIW/QYLrl+8XtzeaqIm9rsEGGzrb5ErvomJD
         Via6T3f1lDjZ7fzTBP5AFlv/UEOeTOphyFe5jkPaeTO7K/1mwi9+wS+74Unj3+HOicc1
         xDpCTjI5Om44li5IdJHzJLP3EzVj/uK6j5TQ//VnTFEVBbpH8xakS3oXeQHL/vzE59bZ
         CUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794583656; x=1795188456;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FO88jd7JN6r4cNWqmQOa06AmPT79EvpBEfyhLQB3b0Q=;
        b=qbMe7Qb2sRcRHJSlRwPx8FAEA6DLw8T4OoYquu/uZDAJyYSou9DgJJg/+6CGCh/C0q
         VtjW2dm7YEK5PeHm3cPEGnTJbwgU7vVrGKirtoqfd7s9cEb96LSEi2oPwNJaz902ELwd
         xWepTGzUEHxeqxrxBKucCImb0AEFckzlg94xrJvSVbFZT+H3Fia3wUPThG5TBfNLcwX/
         Glgo8dISv0a0G2DeTiuEDFsSVrWcIha2nCC7OqY8Ups6l0QYnq/1ZGa7eXGTcKdsZamX
         Z9Qp3NfC96D+AONtNjH/x5KXkgmZAKn+xA/tNx8XenOjd6Yu4xUiHcxOEiZ/nEeIeUI7
         NItQ==
X-Forwarded-Encrypted: i=1; AL+hErGgmwiHLRS7GwveQW77xSixToiduBpxzw76zIDqXscrb/lGPPSVqQ/3vv/T/8J3ZXBo8Zp+uBRG3WFNPbrFWnhpptw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/1KXayPzIzqEgygXeFsOCs+aT9385604yyWasJApGvgZbFqSOv
	s4T1dU/1wugT9F5dQAlB5weA8hHJR9OGuXQ8NFOyYT94xYaSO0k2B/kUdglmUycM927G8R2vT5O
	pLn2zJi4P6XbQ1l6iqs7z1g==
X-Received: from wrwc2.prod.google.com ([2002:a5d:63c2:0:b0:48e:a11:b240])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5c05:0:b0:49d:8d2e:40e with SMTP id ffacd0b85a97d-49d8d2e0438mr1425299f8f.16.1794583655709;
 Fri, 13 Nov 2026 07:27:35 -0800 (PST)
Date: Fri, 13 Nov 2026 15:27:13 +0000
In-Reply-To: <20261113152729.837429-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113152729.837429-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261113152729.837429-5-vdonnefort@google.com>
Subject: [PATCH v1 4/4] ring-buffer: Increment pages_read on remote ring
 buffer page swap
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, bgrzesik@google.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

__rb_get_reader_page_from_remote() swaps in a new reader page without
incrementing cpu_buffer->pages_read. While this isn't an issue now as
trace remotes do not use buffer_percent, add this missing increment for
consistency.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/ring_buffer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 6016d16d1566..ae33e64c7daa 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5881,6 +5881,7 @@ __rb_get_reader_page_from_remote(struct ring_buffer_per_cpu *cpu_buffer)
 	cpu_buffer->reader_page->read = 0;
 	cpu_buffer->pages = &new_head->list;
 	cpu_buffer->lost_events = cpu_buffer->meta_page->reader.lost_events;
+	local_inc(&cpu_buffer->pages_read);
 
 	if (!rb_page_size(cpu_buffer->reader_page))
 		return NULL;
-- 
2.56.0.611.g1030f0b940-goog

