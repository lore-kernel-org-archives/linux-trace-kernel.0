Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988477;
	b=c+Ws9pOHV65ImB74TOKM+klOD6YCbVEV/uGQFZVHUdZ+pZbRNsdbtFwtNF9bIMLjkisE
	 uWA1nvevuMPeqrRpgcOn+xcmgeGJAWqYnUyMLQ3tneopSE4wpKuW4iHSXx1nAdi/HIvMa
	 y9G+HIW0HEyGbH9fuTvZwO4seEDJGLX8mhdCn1l5OAfaW79NjUyPg0sPYE+83Ay7lM2a3
	 w8+FU+qArzO7kDmChle0luk6CKYXU3NGGkdJq8SPJKuLqtOpbifESw2g3ELa84BEhnN6q
	 vvAYPdiexnsr4Cqp/q9q0Xp5Cn6ZVTU87z2FnIIBt5X98eUqS7SGwpqhxGsvlDOSpfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=IQDid1uWo3Rk9LF1eva5xEOZSHbjSCCIc2OFLDyobvc=;
	b=KGrJ3X02Z/KRm6VIQ+1Rg6h/zYHcEWlpWi7Sc525htwKwJOxhOwbKOr5W5QTTyP2zTwq
	 WNJC+SrXqsnMRcxm1SKkt0pwvY0pCcbUM/X8EcNLxDv+OGMGek4QUXYU/MVZCARlER+G/
	 /JV9JT2HizqYsc6hQi3PlHWPh4Fw/ECc+x77IknJoLbaeULAYGF1zITG/TlsvRqgSy1b/
	 8yaw5BTbk1OnTDk8zkMQzRJjILbci71vYG2MhfJLEkKTyyF+KN/+urWrUvp3i8xeaEzkz
	 J/KnBTsSSsRgzJ0TDxVlkdUbfYTpZY9fnSjc2YzYshcDhHN+qwuwPKXC5utPLLCGqjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aT7PIYJA;
	arc=none smtp.remote-ip=209.85.218.69
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEE3606D801
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 18:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFEE3606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aT7PIYJA
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c42f98f354fso97302666b.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Nov 2026 10:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793988474; x=1794593274; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IQDid1uWo3Rk9LF1eva5xEOZSHbjSCCIc2OFLDyobvc=;
        b=aT7PIYJA2fQoZ+jZ03wnsHeZL/5jMK1H9FOgnCo3ezli8FjOT59x6c/bE5Lpm6EXbO
         fMUbPWyOj1tjv6bqErcXVmLabzYeKrT0qCTPuNhtYYY5mOu5q/ohOgjDew5wJ9nvlc7w
         9rtfulsBZaG9Yki24J4sTO3ReRs0wBrT9qt28relm8fFl+JXosEQozCPprxR+h9Yx+Up
         lqqA7Oji+yjdOUxlggg/RRRoRL35LAbNUoE/PciUwtHNMz1M5LgvKYzy8u6VyKWMRbbS
         w77MtJVw88QgbrDZY/pg09dB+F9oqF3d/SSZ+TM2dYc/ldM2yiQAIRvmBsZ9LboTB8Mb
         +QJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988474; x=1794593274;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IQDid1uWo3Rk9LF1eva5xEOZSHbjSCCIc2OFLDyobvc=;
        b=ajzPtTJLJLW56Is9u5N1G0Bv8HfHRC27CDYqHw2BRiTfll8hs89XgUcvCUKhkhw2no
         icNoCHRcjkxBxe8tJI3/2Wubvq2lArm2sQ0G+W8x47pkqYp9yfgXIih50bPdW0iUq8AU
         1jDlvC5t6a3WKgDn7eqt3YY7+tDi5/Ga18kovZo5SZIzkfkXHq/ffyaRnzL8N//RqsDf
         WepFx7Wu31yvi+CrlDKXHOFKFpnOcsPWOn37j/oLMCAW9hRH13Kei/cEiXZAaDBOegiK
         zS0oe/bw4T23ZZ418W8MuOJAicaL2eklwgglhDzGBfaJlDiG71vFHfkwMrSiEJ4uGJNy
         OC5Q==
X-Forwarded-Encrypted: i=1; AKwUvBzLeAQIr5Ddtetcx9ZYBAaCIBJGc7pnw33QFtgRp8MvKPbsrWhi1woXDW06+rZiB3dqGO6OVvpY2illtYpJgylSt8c=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ElxWomqe3vxjq0V7tTOivy30neo6h31zyqN4oJkzKyqEVxQDW
	IgvWuOBa0w/VmepuUm1DWuu+07SjDjBGo+uhJubkXHYzHrc/Uq5HEuuJYft6cky72jCqTKc1TeN
	SYkPWTub7wC4pq4uSWM7DQw==
X-Received: from ejblh9.prod.google.com ([2002:a17:906:f8c9:b0:c36:c42d:ac42])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:a892:b0:c3f:153a:8663 with SMTP id a640c23a62f3a-c4d34bdd8camr263394666b.23.1793988474135;
 Fri, 06 Nov 2026 10:07:54 -0800 (PST)
Date: Fri,  6 Nov 2026 18:06:46 +0000
In-Reply-To: <20261106180657.2460376-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106180657.2460376-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106180657.2460376-11-vdonnefort@google.com>
Subject: [PATCH v8 10/21] tracing/remotes: selftests: Prefix hypervisor folder
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename the hypervisor tests directory to "00hypervisor" to ensure they
run first. This prevents the hypervisor tests from being interleaved
with other remote tests which is confusing.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 .../test.d/remotes/{hypervisor => 00hypervisor}/buffer_size.tc    | 0
 .../ftrace/test.d/remotes/{hypervisor => 00hypervisor}/dmesg.tc   | 0
 .../ftrace/test.d/remotes/{hypervisor => 00hypervisor}/hotplug.tc | 0
 .../ftrace/test.d/remotes/{hypervisor => 00hypervisor}/reset.tc   | 0
 .../ftrace/test.d/remotes/{hypervisor => 00hypervisor}/trace.tc   | 0
 .../test.d/remotes/{hypervisor => 00hypervisor}/trace_pipe.tc     | 0
 .../test.d/remotes/{hypervisor => 00hypervisor}/unloading.tc      | 0
 7 files changed, 0 insertions(+), 0 deletions(-)
 rename tools/testing/selftests/ftrace/test.d/remotes/{hypervisor => 00hypervisor}/buffer_size.tc (100%)
 rename tools/testing/selftests/ftrace/test.d/remotes/{hypervisor => 00hypervisor}/dmesg.tc (100%)
 rename tools/testing/selftests/ftrace/test.d/remotes/{hypervisor => 00hypervisor}/hotplug.tc (100%)
 rename tools/testing/selftests/ftrace/test.d/remotes/{hypervisor => 00hypervisor}/reset.tc (100%)
 rename tools/testing/selftests/ftrace/test.d/remotes/{hypervisor => 00hypervisor}/trace.tc (100%)
 rename tools/testing/selftests/ftrace/test.d/remotes/{hypervisor => 00hypervisor}/trace_pipe.tc (100%)
 rename tools/testing/selftests/ftrace/test.d/remotes/{hypervisor => 00hypervisor}/unloading.tc (100%)

diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/buffer_size.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/buffer_size.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/buffer_size.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/buffer_size.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/dmesg.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/dmesg.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/dmesg.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/dmesg.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/hotplug.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/hotplug.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/hotplug.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/hotplug.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/reset.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/reset.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/reset.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/reset.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/trace.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/trace.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/trace.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/trace.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/trace_pipe.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/trace_pipe.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/trace_pipe.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/trace_pipe.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/unloading.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/unloading.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/unloading.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/unloading.tc
-- 
2.56.0.455.g6c5a503b38-goog

