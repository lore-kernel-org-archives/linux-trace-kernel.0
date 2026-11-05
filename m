Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793910506;
	b=Xt36u7qKwHfbzrmHsWZ/lPcAHqDomrOrf8t88HaC+HebWxV7oEkiz5a5SuVSahqw5e2i
	 /WvH0XUpfRTKe9A8TvxFW8XD5YT72S0cR9McRaCNOWE0V296p6fb6gAbiO8EOUHuK4Hx5
	 WfdjG36iBR2gm0wSeDXmHgxyS4tj/nue0kr3GT782RMsGnvNRd6ZAeFNJj/ajNZB9lPYM
	 7b1Wq4REr4Z8tTiekMCJoQrWIc5mg8KSJPIs5+A58HBhbwCrSkiTHqNDCeODwHM2cM6oj
	 5FLl6viP08Qdd5fGEdkpL3L4dvT/TDQaSxjXudXaN/GTtTZE0DyErgGDtTUIjZztJVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910506;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=n6u88J1zozBh4kFSEo95PNcaqQJ8WiATMgsSjSjkODM=;
	b=5OgYDgtojOfBadzyFvnnQJgdYOkWWX6k3pby0TXbjNOk37zbpfv+JUjmepLsdNkafTp8
	 RtXyWX7oClh6jiplY08kXEKmsxlaGlVgoW/ynE7K6sHIwc5LsqcqtJHMtn8kn7we29ZcB
	 jOozHS9JgLXZZQFyCbTmAXZ/NSIfwZbGhjbNBCgy/pzbUMbph8RsSc/xQxalEbnr4O7EX
	 b27ALbM9x0IjIBq5DtDPadQW3RQKhwev6OrynF7gokzcY3f+riEvHX1v/rP6V7XXa1Me/
	 vc75ScCv/ePnD310K/sGSJC3ED5vzbP08rMxhmwBfaZtsfMMChYzla7UViFBU4yVoBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZfZufuIh;
	arc=none smtp.remote-ip=209.85.221.70
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C770606A338
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 20:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C770606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZfZufuIh
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-49166c8a60dso937551f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Nov 2026 12:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793910504; x=1794515304; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n6u88J1zozBh4kFSEo95PNcaqQJ8WiATMgsSjSjkODM=;
        b=ZfZufuIhYzcCIVsVooKDuL8PYkUI4jjGGU7GP5z4SkMu1NKzF4+7WCa7Ad+BN0jX6E
         tunwdcehPLOg8pqiEjO5H4jQoeRlXKjPMf7m5iEeHFVGYHIPBSvncoRbfKda+86I6Ebt
         WdfpVx2CTY/AjjN0kNi4yoxTYZ9Mo/XtrSLu/fQfMgj9pn/X14pgJ9h9GXgGZ1rD6DQS
         8VAn5rCgpJQ+2+5S3FXh35XDdPTC8kv5U6fSJ0wjCIHOo5E90GASLSMZVVwcQC06RAwp
         s7zIZ6ICZeZQxg1R65ZSPAeBzA3ShfpxKeTUCA6pNbTiXzJ+tKdUb5f4yGZb/my2DAHN
         /Qvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793910504; x=1794515304;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n6u88J1zozBh4kFSEo95PNcaqQJ8WiATMgsSjSjkODM=;
        b=N8tUfQt6wd/90iV6/k+o0yRVeNfFAe+GRA+CL+EQ9adMFVsGhTzBaRkKhOD0QGOIPr
         9rZtbo46AasRMjiQLj2EhtO0OWZ+w9Br8IFM2kFw4vHQLSK9vioms4vsmVP7q+D+Rc2j
         kQaH/g5sgi5LnScBCC737DSXQVloeoWpQqcAyel5+ffnQMIf9BRtzha+35XZ8vKdQ1gx
         bMkv2RdM/Wnyz/ri61Qa+7Lp0VFf4QgPaQQ55/1aHVqp8/eh0VQhsiQ6BJl8B7ASKnIs
         t6Ed3x311YLLJEVyZVOM1XU3Y15F8r5DwtS/qxROOnmlyYaEb/noXyQGn6cf+2TEYCGv
         ww0A==
X-Forwarded-Encrypted: i=1; AKwUvBzvNf/djR4O4n8ZmqsypuIzwKx9OB+Tjjf8JjzhwECQK3sFepwdfQurUBZLtNvDvexYX37XTqco72/hNuVglcxlCc8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+sTdE7C21IkttXjO32DYeEjPYaYxDJxxxJsUWknyx8EFc0dy91
	ynh/N0iFOGc4cUr81lgZ0zKY2djkdHlqKuXac5+5DIk23/CznkF6OUAX9nuCqEbv7fhaKgVvNRX
	yjJDLl8p7lp75/5Am7qhVvw==
X-Received: from wrqb7.prod.google.com ([2002:a5d:40c7:0:b0:48e:ade:5b83])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:402b:b0:491:3fdd:af42 with SMTP id ffacd0b85a97d-492777dbd5cmr1404295f8f.37.1793910504239;
 Thu, 05 Nov 2026 12:28:24 -0800 (PST)
Date: Thu,  5 Nov 2026 20:28:14 +0000
In-Reply-To: <20261105202814.1350312-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105202814.1350312-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261105202814.1350312-3-vdonnefort@google.com>
Subject: [PATCH 2/2] tracing/histograms: Drop stale absolute timestamp note
 from docs
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Since commit b94bc80df648 ("tracing: Use a no_filter_buffering_ref to
stop using the filter buffer") stopped using absolute timestamp for the
histograms, the paragraph about timestamps has been stale. Update it.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 Documentation/trace/histogram.rst | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index 97b67f05f5ea..9b301b86a4df 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -1676,12 +1676,11 @@ features have been added to the hist trigger support:
 
 A note on inter-event timestamps: If common_timestamp is used in a
 histogram, the trace buffer is automatically switched over to using
-absolute timestamps and the "global" trace clock, in order to avoid
-bogus timestamp differences with other clocks that aren't coherent
-across CPUs.  This can be overridden by specifying one of the other
-trace clocks instead, using the "clock=XXX" hist trigger attribute,
-where XXX is any of the clocks listed in the tracing/trace_clock
-pseudo-file.
+the "global" trace clock, in order to avoid bogus timestamp
+differences with other clocks that aren't coherent across CPUs. This
+can be overridden by specifying one of the other trace clocks instead,
+using the "clock=XXX" hist trigger attribute, where XXX is any of the
+clocks listed in the tracing/trace_clock pseudo-file.
 
 These features are described in more detail in the following sections.
 
-- 
2.56.0.455.g6c5a503b38-goog

