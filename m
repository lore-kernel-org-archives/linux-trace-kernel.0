Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60312340A6A
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Dec 2025 17:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764957164; cv=none; b=FvnAcVAY3qF0D4PK7vys9Q/TRfnbJv/ubEN7jcPmT9YyQzumll2PDMosxWUQ08iC4ExbQKlNceOKy1sXrlnHZfuAW6ES/uLEcC596fNjRQFUEcPM0CX9LzMesantW+FDarLs5hYFs5m4Bjho5dfTuYC1202EL6YCsT+cjTjQgQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764957164; c=relaxed/simple;
	bh=11kvn6R0v8rSS2QHl/rgXeoyj0GXSpWYWmX0nrph0+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZD/zj3yC4g0K6crpbtkZYiOoSzCezODWjQit13DdFqP4l0fkez6OFegDHpA7GBCvsNkUO7pExChpJpaqMsQvEvUKwhXtX2/NgyQlBGo+HQxp0ED3CanI4a9pCr4AaiwSIflDmCShhAJ0/cpJG74CC7acjyZuDjJMYj9qDiMFUoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKt+mVpp; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKt+mVpp"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-786d1658793so22032347b3.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 05 Dec 2025 09:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764957159; x=1765561959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vhdM+o1UMOQThbgKivVtaRHqRyLxM9uhOvolJtsLWEk=;
        b=dKt+mVppEaQGM0jOP5Ob9AaDf8ISohEhzW7EpI6ZBiDfJxrjg/l8PwFG/aH22Scdfr
         qZbx6glxlhZoE7kZjbjOq5mBUQ6XKDnCP7bwUhJIkvgrtrND1yf67nHyBy2JAsKLgGpw
         baW6Tyr+m5cyuIP5PJ29Vfy19wAFhe3SB8IU5nrTy8SL5XaZVQnC58VmsWK2aJjYtfIa
         qdt4tiUrx3iP+NRLuoK+L5tmIhdROBwV6TJx6VFmGU8DBcl3I8BF/jJcGYWn5HB7G8rK
         s0SK3/pNCDLSpn+qYjYcRnqdg28BAcVPp1NNNsLZyRHbRf4q40aM9d+Uw1Gj/7qU2N/R
         LYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764957159; x=1765561959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhdM+o1UMOQThbgKivVtaRHqRyLxM9uhOvolJtsLWEk=;
        b=nk6Vtxoz5u+QmmS76JBdxNtFibzgVksps1gM6AxMMbvFUivSt/ra6rDJ5vmktXGdn8
         4q70z3x5APpW7etjBCkbvtKRMg3zMUsuD71m4mqBTemPu4G8r37ZazpiVWkFiFiZ8QpQ
         fzpvILD9wu95MQyPtq4sbB96ItUg21hXa2Yl2jcE8N2sxdn9tglGft2wK3vQqUhbfBRP
         zkqzvzTyuBOA552dN8JzvWJ88Go1sZJa1PFnsc6K7r8jE8IWYrkyw5yRqFH8pUNqCjbH
         XwcmukknBfMMGIg0+hsgfUw5PkX97mRpvD7cU8Q25mKFFPBcdD++U9WUCKkGwTq5yC1l
         ho6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQbBMV13NDMaen3kIjVGSJbOpXA+uP27JLE6bywSotYNn+qe+B3zLQBqoPv7EMPRIFi4VaelcfjMa+rThFqQ/IkLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCkbSSBD/K0q0ggXgd7uLjPk3jeOMKDpvtFMXcvnNnlI4J+ysn
	QYBKE24zAOHxQI97dcg8hRkWnthdN+UsacK7as7X3HHNmY0ildHfHzgW
X-Gm-Gg: ASbGnct8iksrsloxV0L1W35G+knx7c9LWXWzXgvMLrIVlP9+kiGnORvw/XSHjZzERji
	ZssegMULQ7rXY6BAdBzmy3uVoIcpxunvmb0vWdxNZzgBRwcS6N4ACw33GmYFdk/BB1QO0AoF0D8
	C24cww58qWcZHv/uxFAzsiCtvMOSsQr6jPPO/Yz+wzR4DNwzWnp0Uks3qMj01GxlC5L7/IwVys/
	4SXBgTg5GP+gnmgZDiaci19JpofDbr1yrldPCPGssCUfhkhjOF6o2IxckBqF3aKDrJBCDp6pwOh
	Vw28hnf9X4oigH3dl+W02b6a6Umsnq20+57Z5pJsOCGWLocM07PbPgbn82+boxKsPR6QhLqUBQ0
	65woSohVjflpD3LIkMjFmIYkOUcTysrIoXAgUK1WkvyXV5E02V1sR8fS0rYF62EVGv1d4DemELb
	QudZR/ng==
X-Google-Smtp-Source: AGHT+IGjlOLdXC97l6OEpoHY/ijeCRrrzo2vSMNi38e+iaXy3/qirDbODXQrNjFzrIZENzbiZevXPg==
X-Received: by 2002:a05:690c:4989:b0:787:ca87:595c with SMTP id 00721157ae682-78c18600ac5mr113255467b3.9.1764957158797;
        Fri, 05 Dec 2025 09:52:38 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:be2a:7e4d:3bf:3fbc])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b4cffd8sm19112287b3.13.2025.12.05.09.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:52:38 -0800 (PST)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	David Laight <david.laight@runbox.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH v3 0/4] Unload linux/kernel.h
Date: Fri,  5 Dec 2025 12:52:31 -0500
Message-ID: <20251205175237.242022-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel.h hosts declarations that can be placed better.

No major changes since v2. For testing details, see v2.

v1: https://lore.kernel.org/all/20251129195304.204082-1-yury.norov@gmail.com/
v2: https://lore.kernel.org/all/20251203162329.280182-1-yury.norov@gmail.com/
v3:
 - rename linux/tracing.h to linux/trace_printk.h (Steven);
 - cleanup headers better (Andy);

Yury Norov (NVIDIA) (4):
  kernel.h: drop STACK_MAGIC macro
  moduleparam: include required headers explicitly
  kernel.h: move VERIFY_OCTAL_PERMISSIONS() to sysfs.h
  tracing: move tracing declarations from kernel.h to a dedicated header

 Documentation/filesystems/sysfs.rst           |   2 +-
 .../drm/i915/gt/selftest_ring_submission.c    |   1 +
 drivers/gpu/drm/i915/i915_selftest.h          |   2 +
 include/linux/kernel.h                        | 210 +-----------------
 include/linux/moduleparam.h                   |   7 +-
 include/linux/sysfs.h                         |  13 ++
 include/linux/trace_printk.h                  | 205 +++++++++++++++++
 7 files changed, 229 insertions(+), 211 deletions(-)
 create mode 100644 include/linux/trace_printk.h

-- 
2.43.0

