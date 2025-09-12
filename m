Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01312F5468
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672026; cv=none; b=VQD2OZ/XQ1FJqxp9zFu6joQXk1IosEpakLWNSGJWUBJKOYwzs6HwxaeUrTTeCiRC826yN8OQb6GPhERdOvmEZ8dbDOdQLlTphpmcr1kBa/h8Ifo+lduv97MtwEVJESlZHqpNApiV1MoBXgTlpTF6u+6Udlq906re8d9XaiTJbzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672026; c=relaxed/simple;
	bh=Y4IVRGt4gY6CeNENuQfFMwDoOjrFFT/8PJdPjuvJ4cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdHTtXk6L70W8PSrD+XAjsr+Yi/iK+IDdmwo0wmjI9rLV0hUBujLmE+OKpUJ+siDcjEtzhmYm6PlC0iASAw+v2su67o5Mwb8rORxw8TWek9wCBb5Esg404R9l3qoQEZVO914M3xugyMjwVgZwU6xSIQgUoD15x3OMfHRC/GHMfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqB0A8Nr; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqB0A8Nr"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77251d7cca6so1708196b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757672024; x=1758276824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I55bZq7ZFzzpD1DxoyTRdsSYeFKQhRWPVd7TpHbtt7w=;
        b=BqB0A8NraNWmI/g9eWEjwuUs03vZr+6jF1scr8Z0C0j3tZlufwEalQgqxouGTUTUAx
         QFn4nayB0gwNYyI1P4qat2hjPKoMHGUf/0NWH/FCW5n4DcaVVb54106BIZv1l9kY4Pzu
         Kpsc7UO3nd0yzNxIqBApWfFYgrykwBKdJX98Ukx06IPIpzg+dLuvL0rEvXWwY7LzEUvV
         GSZfrHOPVyo+RXZmH+nyxRU7GHns5QWPhUKbioZUjK/IW8qkYT7HQa6+FnlFh0P9KG1R
         bkzpf6rb23CJoWsTu7iXTKyu7eEiRKcPnJxbzIJJhN7JYodBIMgK+t5f5nErohzICzXL
         hlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757672024; x=1758276824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I55bZq7ZFzzpD1DxoyTRdsSYeFKQhRWPVd7TpHbtt7w=;
        b=wgmE0F6L5S8RRVDN8P8yZEPQnIs9J18mEoEWsfweNjekJBw8+DVzv2e99JzMtUgExm
         9FrYkGeIesmb0yM6w9bBmGdFYzicC+wxAuHd3eljkXtUKlf9kv/GxJI3XXnn+IUrBd0N
         rAuT2xXaH0GZ6vdLhBtLc0CFUxtctwlgiiu3W2OML1s9o59F3XIzaHCzgFh+V+J/pmVj
         I/3GO+TqIZFyHZWaU5e4MBtjMghuwlaK8B6iZI+FRLKLU1txiwVwl/3VOUZo4gpfqita
         vGytaFkBZnqh0hIq3ZfvbZLufAn4DbRBRnK72IsnDgcqUYvQW2gyvzBXVUkth00CftWu
         jJZg==
X-Forwarded-Encrypted: i=1; AJvYcCXtgoaLxsFlVZg6s3YRojb0jSypLEqke2vn4i5hGEr9lKh45nvDmRVUF28mc7692eyetaRL5LVWQJD4cwHh9DJ63nA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzM13J7ULqViUMkjFM8viJkU2qD7jYzncgCrbKl074FxkZb7xR
	fBq9McZqtTm7vsvEr1l3R1m203I3k60Btvsd2E8XLzXtNTubVOyX/FiH
X-Gm-Gg: ASbGncu+nuz3xLry4+y8L3O5hbL+RtcoEj3ogR2TrnTiPjrFLLo0IheF0s5xlRyWwQA
	zIivSkOV6fpd8pH3oc0aav+rQrARt4S3OGOt/3S386CVt4UEt3ex7A4ia34K/lP021jQxt45AH/
	0/DUT0IPErHhNxKe/hLP+cKiTuXIM4mp7J5Q/aiyBgYLISaLlcSDWxSUwo7uByo9tozD7eCzDC2
	+pbMmSOcA+3h6+RBSCutJF/4VHvNsoTvIRxzX2gaPh3MHtLnYlq11O2Xuj8Dy/wBnPdnw2oaT+X
	QtmSkAe66kZmcwS385Ytb3f5pul+H+F3GYTmCb5j3/4Pmk/IjYdc4K6LPXURR1q70Qv7TrK1UFP
	5WpwpivLmAI2HgCfdrqBCgZ39DgekkaYnpGjW2mqkTxd97g==
X-Google-Smtp-Source: AGHT+IEmU8/7QYE28ulPnmQWl8v4TOjFN/LND+vjp/ORoshKulgXE7ro2NJTOczUKB1xsXbgHPgJeg==
X-Received: by 2002:a05:6a20:734d:b0:24f:53e8:cca2 with SMTP id adf61e73a8af0-2602cf104d0mr2912224637.60.1757672023846;
        Fri, 12 Sep 2025 03:13:43 -0700 (PDT)
Received: from localhost ([185.49.34.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a3aa0f8asm4307035a12.48.2025.09.12.03.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:13:43 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <kees@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Rong Xu <xur@google.com>,
	Naveen N Rao <naveen@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Nam Cao <namcao@linutronix.de>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com,
	"David S. Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v4 21/21] MAINTAINERS: add entry for KStackWatch
Date: Fri, 12 Sep 2025 18:11:31 +0800
Message-ID: <20250912101145.465708-22-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912101145.465708-1-wangjinchao600@gmail.com>
References: <20250912101145.465708-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a maintainer entry for Kernel Stack Watch.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd7ff55b5d32..1baa989abf2d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13355,6 +13355,14 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
 F:	Documentation/dev-tools/kselftest*
 F:	tools/testing/selftests/
 
+KERNEL STACK WATCH
+M:	Jinchao Wang <wangjinchao600@gmail.com>
+S:	Maintained
+F:	Documentation/dev-tools/kstackwatch.rst
+F:	include/linux/kstackwatch_types.h
+F:	mm/kstackwatch/
+F:	tools/kstackwatch/
+
 KERNEL SMB3 SERVER (KSMBD)
 M:	Namjae Jeon <linkinjeon@kernel.org>
 M:	Namjae Jeon <linkinjeon@samba.org>
-- 
2.43.0

