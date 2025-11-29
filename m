Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916A2262FD3
	for <linux-trace-kernel@vger.kernel.org>; Sat, 29 Nov 2025 19:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764445989; cv=none; b=Sykjd2q0TyGTWAvbSXpuxu6SulVU5uFI6a9W//Rtv0XmenIruXf57T5C2xQGmQV8ngEYT21G01o7PIrvrUqjmjchOIoySVi6dKEHSrOvepDrcUigJO2VQgYZ5mjMGj8lsazpzy4Fb7JsDo6qdzapQSu+wa2vGQFIe+9z0PCvrwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764445989; c=relaxed/simple;
	bh=UYASUc3+cc9N6xfCjk2IMzWPz7jySHVohyawDKdKyww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YERaCYl1nybO4frr84JL67JNBchS1gguV1mK50NCuUl9YizCdj0bpd++160QQ0KbZKhxEwYci5ELYlOiQjTmTczhnuAgkBmuSL0+/TEo7FoMyCgnAw6fFJa7QUM6Qt8jtLONgz7ALydXK+ghWog+KJuAyvErvcGY3xF5qSChhjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ill1EMR6; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ill1EMR6"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6420c0cf4abso2707233d50.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 29 Nov 2025 11:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764445985; x=1765050785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bq5yUqUCzfdjLEn9031/L9EMDQ3XGvUTCWlQPofKw7E=;
        b=Ill1EMR6yKc61BY1eVYp3ogR7LmwTIfJH8DSoepqB4ATUWILikHzeZGCLIfTl7jah9
         fmFjk8v6NNPOTvXZ8ywrW/RClnqlcBLVpvkiwGki/r9uYDIKbk1RVWX7agdS1USedzPE
         YKxECNPIpg/8HSMypEKrjZ+I7UJ8Tw/FBVRLa1Y0mkclRpW65sghE+MY+18Gz+MafOoi
         Yemg2c0Rxic2nkArfhEEGwZhadAZ4eTtW2dI8+IBqz0ammUbvROi7zwzhErL9KsE1AW9
         aMHGXTFmLj54nwY68Cun43fHGvHtag5ehAdBxlaNE/mBVbMyl3ZYvIym7ginzRjrhRzY
         jP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764445985; x=1765050785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bq5yUqUCzfdjLEn9031/L9EMDQ3XGvUTCWlQPofKw7E=;
        b=VpJ15SlHBDCDvX68WPkp8niKMe2+xofqt6B6EtO7p8VOrrkgomJD1Am/lUf0/krSI9
         OeYcZng3bRsA1STuc+am9R6Ox0VfDTj3e9IvRiE0AZs/7DasAJpz4aPYU6ItXfAY8FA2
         wGm1VWJHYLPZPjEg7zvCwRDFhsRgSSNv4rlSJMJkIo+kZouKGeRL9doogm/FcoAXYLQ4
         /o+mIB7jiY1mCx1twc7ylVQZMbL3QkjXw80c2s/zdUl0ah3Pg9Blu8dlC36IwHdfIC+Q
         pzzFV6Ie2qit6XLp7QLc2b7wWrrGNZe2voApko7RbyaogS++xFMI0DNghUZYEmo9mIP9
         HfJA==
X-Forwarded-Encrypted: i=1; AJvYcCVYjHBdK5zUxENJzQaSy3lw2pyFUp5Vja0IrgyUWihHTVO+4Mieinj0du1AGsTO8DGbXIOn0CgPkEheBryUU9VQzDU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq5RNV+Zr5S4dqqKb8vq28JGpWGp6bccvCtxPo93D9LfYDKwjx
	nDwgwvtVtA7kkR/VR/q3KrOuxAlb8iQYdhFETbXmm4iU0SXwUh7bcz0M
X-Gm-Gg: ASbGncuTP8g+MXTVYpetZ8iytzDr2ddzh/5yKmbzXURhJRlNTi/ZEluHNbsT3tfCFI0
	y33ItkHf8dVyJ/RQH4Lm3rNNyXjh/ne0VoG/54hqQJjNYVrqMV7GqsMwVCv3/kQn42A0VdEVMzF
	AgwL2VMJkqU/UfbrvviFQ5d7V9kPos4pWGZ6A4QCbJCUWc0E+ecnCr8xbm0KohJ5fSGZp+7gqTn
	p9+aDGKfkz/rrOJu7qpXrmYACDbtDXi2Aqj7lP1yHPPclKMlA49TrVoTuyySKRhZL8vwLnA64xX
	gggi5NPu0T3LUpNIi2Rs5GLi7iMQQpL/BJSiz1NeDxBoteBnp1ng/pr3996m/etWjOKkSuU5sui
	cp31X32qeh8M/nap1sKfuwHKRP0ZXeGtxliM19h+aqf17mRaq7jt2OkLABQ1Qk9OOG4Kox/Jspd
	skM3R/yFs=
X-Google-Smtp-Source: AGHT+IEfj6PVUeeY07J7TJfo/pC02NnxeqqVhA9KwWv0e199pnEc7YIXLK9r3fHsMgALzxDeBf1gGQ==
X-Received: by 2002:a05:690e:1510:b0:63f:a8db:47b4 with SMTP id 956f58d0204a3-64302a8f75fmr24324286d50.3.1764445985371;
        Sat, 29 Nov 2025 11:53:05 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:353a:b6ab:d4ee:67b9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad1044f9esm28751737b3.56.2025.11.29.11.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 11:53:05 -0800 (PST)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Petr Pavlu <petr.pavlu@suse.com>,
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
Subject: [PATCH 0/3] Unload linux/kernel.h
Date: Sat, 29 Nov 2025 14:52:59 -0500
Message-ID: <20251129195304.204082-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel.h hosts declarations that can be placed better.

Yury Norov (NVIDIA) (3):
  kernel.h: drop STACK_MAGIC macro
  kernel.h: move VERIFY_OCTAL_PERMISSIONS() to sysfs.h
  tracing: move tracing declarations from kernel.h to a dedicated header

 MAINTAINERS                       |   1 +
 drivers/gpu/drm/i915/i915_utils.h |   2 +
 include/linux/kernel.h            | 209 +-----------------------------
 include/linux/moduleparam.h       |   2 +-
 include/linux/sysfs.h             |  13 ++
 include/linux/tracing.h           | 203 +++++++++++++++++++++++++++++
 6 files changed, 221 insertions(+), 209 deletions(-)
 create mode 100644 include/linux/tracing.h

-- 
2.43.0

