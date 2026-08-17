Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BDA279907
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974936; cv=none; b=RgFBCP0wnq55LhRMDzX1oY5M56sygUM51SnHtL53huxz4KvnY0Ci395Bv2GZmZiwDuvJ99gXARyFLjJLE0DP+R0cuDxhp9JmC52FxVkaw5Xkxgh+ReMQbi/335IfYnxSX/gKYOlK+75jh8PhS3lZKN6h9loZIucPUqlcvIXk8u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974936; c=relaxed/simple;
	bh=DZViWPy2+2sy/hkFebzwzqzhjCCRLljq317GDvgSvPM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y71SR3c+EO1U+y0jDp5fPr9LbtFpRx7Ba3wyXV8tV7fBqeMGD6wiWAGCPegd/R+L0rKaSZfrezPSUOnB0FgkpW91LPjjvPHJH770ihYxFeAvLE/Zha8v40UebmMhgyWuLfIXBY+3vXBGi47yhgEVT9Qk6LY/9FCspYKK9yeC75o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BykoIqiN; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BykoIqiN"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4997b060af8so20735345e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 06:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786974929; x=1787579729; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sD1OVcnleQWQNe5py72F53Ad0jsG5MJ1gMcK57vy+8o=;
        b=BykoIqiNI97CeQdvwvATPhuDlKhGNj8hcfBgkSPffP+PLxbrw2E01NKEHveh1Rvtiv
         Bqhxg+TlI5erl9CgTLkjNY9m0LAlBeFLAiDHXnqQXxTL3wiE4B9qKCJ+aAhV2dpfKYsd
         6H7kDFxJOpIlaig4/P9gA0r9alkpjK3CNPQHkaxgjKTl1upHRvqLqapNSt6NgrIRQmhc
         ivxLnnq0D8BVC1gJvFLPlKNUBavEyryuQfXwU75HgI/tXvabaErzat4QMigRNKjNt7cn
         +NJhvGoDBZUsiVj5dQc2aWssC8XHIGVMBj+B+QJMHPGtA8COK73PeWA3Ik8Yt07JP5uv
         wibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786974929; x=1787579729;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sD1OVcnleQWQNe5py72F53Ad0jsG5MJ1gMcK57vy+8o=;
        b=Yx5rZcECiyVfoYP7ELY1+skFmQZV5xoURr0WJy/zXa2sAVsHgtO/t02E7Hnzz2uE4r
         HV008a+y5v+lWeoz3enF6OwPsPHkii4jkjL7UU+xKno7QcGFI04FDQcNRj/BYA18SbV4
         9M1YfTIEAA4Th9DN+gr12WJ6kq6vvVMFDwbbuLS4AmZ8F9A2m2E9hW5bOlGdToTi9yNi
         9VupRgACZO6fDdptz8nvNhjyJao4f1aoysYNEpAja8tIzWeoAQRTAThTLS9AeALgYbEW
         9CAEXKxxfMOWhnFzpuC/bDVAkwEjszC5bMAheXrC9ND9R0ZXeg+6lBdacw1LG8gUoyl/
         2Clg==
X-Forwarded-Encrypted: i=1; AHgh+RrRTl4eQqYrpokQmSrYg4uJc1buuE8nJ5oXUcRHMo7/xrNuimPCl4Mbo4Maqqg4T0YQ2Qcz8MK1z9K0YIc/bR3qaBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiX0/MitXGwTGA403l8v27V+59mNpX3bqVqxXRUh0ZMbELhh5O
	wJ8wIIAsUDWERzJs04MlSwTmAXQs+YbdMS5Ggt8N30W8gggJa+KdkJSLtauir1IB3kLOSmxnd90
	t7WqcZm+kkrhp63DIWMbwAQ==
X-Received: from wmxb14-n2.prod.google.com ([2002:a05:600d:844e:20b0:499:8f0d:36d6])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a7b:cbc5:0:b0:498:261:dd93 with SMTP id 5b1f17b1804b1-4998799bb46mr241604285e9.18.1786974929008;
 Mon, 17 Aug 2026 06:55:29 -0700 (PDT)
Date: Mon, 17 Aug 2026 14:55:07 +0100
In-Reply-To: <20260817135517.3919534-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260817135517.3919534-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260817135517.3919534-9-vdonnefort@google.com>
Subject: [PATCH v6 08/18] tracing/remotes: selftests: Prefix hypervisor folder
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

