Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE64471423
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551237; cv=none; b=iDFK8lIRE4yGXt6u06FQeuMRuK2Ner+eqXo0B3HPESAn2QTmA8mDTk5IprmHAhN/FoDOeovWW31SSTMoscL/nfpRZ3BJKhAyYMmQFt/Sd1XQvzd3dkCoSAIAw7/bUedKJTLjDqv5GT9neZFqA1ZEKiXnmORIyhmKIduJ17I/h3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551237; c=relaxed/simple;
	bh=DZViWPy2+2sy/hkFebzwzqzhjCCRLljq317GDvgSvPM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ASifNchjQhJxpT/MqWiw7Fcg6TiyLrss6Mio8Vmw8lts/sHOjwrZXx0+VregU5jcGzN0yWCWnrUjQ3JURhZY0E9CUR9R+shLzwh9+5aQFZHbdqt2J6lNEFM3uokrBKMWXgaKQIjkU3bOxJFlpkdjoqT31xoRJgZAs7am9+8m3mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G3Od1X8h; arc=none smtp.client-ip=209.85.208.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G3Od1X8h"
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a22bf0so1153619a12.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 09:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786551233; x=1787156033; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sD1OVcnleQWQNe5py72F53Ad0jsG5MJ1gMcK57vy+8o=;
        b=G3Od1X8hPAvVtpLkE2bVDKf7LyTWS/pRguDWaUdMUrlUMxVFqXlPDQZfw5T+L0CRD3
         BldCYB0EG+RtVFqoOmKpP2ZySlDV8jaosstHA5bDJ/UB3lQfGk2cVa6Ll+2CMkruBGoy
         x1NZ+iGylXSb6taZFFnNksumMqcECsUhTGpJMGRyxE6E5p42aslPdjJ/zQtIiI3ras46
         xvfxrmKNtwc51MsAGiCFSpGmlG7w6TXIh2z61jTUKiBpRzSKrSI/WFvfUKSZh4bj0o+S
         r9n9MA+nwIY+kG/p6Ee6Ow0X6I4PcZLROMUnyL1H7BwVeVL1WYwL3nMt/M6MYLz17rk3
         dywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786551233; x=1787156033;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sD1OVcnleQWQNe5py72F53Ad0jsG5MJ1gMcK57vy+8o=;
        b=rNJmnGpL9Bmo8XMPvIA4vc4NMGKKXmjeGfs5mDRMAuqPp4rCMC3cwAUi41iv4JTsrS
         sYO3fEPn2R0f5ozSJZGOJKciycY/2e76blEc7PJckX0DDVhxYtg0g4+Qv1pQooluPLuy
         7DpKPeJ9q+E6NY7Wp3XZQAE5BNeJLe94YnbJOOX5g/RQeI068a3DudIiu2TMCW9P9u7T
         RHL4PxBNMTotLszC3nkQTAABD2zSgABBz1dQxzbk6uGtSxGDfLH8KryTVz8GP+06TmnR
         D+8knzdR5pDNc+dfKTJMsSq8JXtB17nENxfraYzfV470hcvlYGoMU+z/NzrT5uV9SimB
         /KtA==
X-Forwarded-Encrypted: i=1; AHgh+RoKU/wQhMrO8iBwnwcYIfogtRSjBF5KDj+L2mszFpy2R7INayvdjlAcmfqu9xja39+G0qDAIhwjN8y3JP+Q/ANJQIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxANpFxCG9NcFBeI9hhb7iQ2UyLBusWrIu+iLAylDaZudSb0jR+
	Vs6MD6PWFjQFldeQGBMSxKqwUI7qYmLntEPbsWdjrBdBK3qzyEKaDKw3NPn3In5VQsQW7BWs6Rd
	v9BrRois5vjRyD9H/hN+nqQ==
X-Received: from edsf2.prod.google.com ([2002:aa7:d842:0:b0:6a1:feb5:c56f])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:550a:b0:6a1:284f:7891 with SMTP id 4fb4d7f45d1cf-6a375ebf7aamr2799033a12.7.1786551233259;
 Wed, 12 Aug 2026 09:13:53 -0700 (PDT)
Date: Wed, 12 Aug 2026 17:13:30 +0100
In-Reply-To: <20260812161340.2417322-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812161340.2417322-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812161340.2417322-9-vdonnefort@google.com>
Subject: [PATCH v5 08/18] tracing/remotes: selftests: Prefix hypervisor folder
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
2.55.0.691.gc56d675ccc-goog

