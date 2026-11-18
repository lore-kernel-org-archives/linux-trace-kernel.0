Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794978260;
	b=YGZ0kqQ47W38VSL4fOCcyutg5UkN2Aw9OrozBqzeLzis8+5d1OZgx5d/tE0L0QSMASo1
	 5rtvFcZCfeUW8M8jcZ8GN5gRuV1DjBg8NRQ1I8UfqKpZwMw0wjAvJWrTZFOrlxwMR6cVE
	 JwwJawxtakaIJcoRZPKn3nEacqD37aoiYZ8FxPHuR0nIuHS8N5y0WbB41D9CFgToj3U2l
	 qFLNuM15NSGJQtoICkgYT2h5YGQOXsLhVpwvdXC0oUHtxKxfFNj+ZVvdnXOwe1/f9lEAk
	 il8YJdgF2o2W76sGnwtqzrmiCyXNpM0aD9d9KV1TY4YODoq/8S0QP4StJrJttLwL9PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794978260;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
	b=oD75W7RRmt/qSUIDKdoxVi0HPTP7SEn+XlaLGqVpzpUVma2HRfhes7bjQF+VAKtILrsH
	 OOAez3P/vVcTIy5SIK31NHzbN8FE05WrLCEtalj87nUwThVen6XxdgTUdVoiczUIIu6y4
	 2abDxL3OW+fRBYkTppYzxTYazshE/TJLwE+BY3ZA6Pt2mgizviu7Tx/RIQiWBxbku1LQV
	 RknuzQskyhNdfhv2YGb88vS6og8aWmeBKIvnNsQat44sGfIpgWXZj+6XxJctzDFvsEiiP
	 NECGIQFCX+qgKSqsROgfgQLkkOzGv3/88jrY270YqLGJvvPglSJeDgfZqqYITGa2qCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FDC606A325
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Nov 2026 05:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44FDC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4cc89e86e4dso606125b6e.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 21:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794978259; x=1795583059;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
        b=DWIiwMbC4Oya9uGm9FxzuuFRKuuaKroxLK+h1L+4rfnGaWuYk+J6x7gYTalUqeChRb
         9yg5wu/z8hxNVV7+nOPCA70+lXq/LAMOQwAROsRtQ2WmqyMr0U8iJtpqiIcytbLmAr+E
         eGiYVOsEf0BfCV2XZu18bOXOLz01WPsPj56/+SOl6vXFqqlmI77Jv2NkU3QWWKMLCbAR
         1LFfvzlxJri07EZy6mH9EcJtVQQXZKmqysA46/PuxI4I+0XO2nourLi0avJ5a6hQhcQd
         0U56xBNO/PAmjjJ36QPXX1lGjk/FOB8jKhX6nqdoL9k/OhwGM4MgaR1WAw9wVO6oKFUt
         JaYw==
X-Forwarded-Encrypted: i=1; AL+hErHxjmzB5gjnB2oe0BNhEsoxADLEnk5rPwsTuhf7FjiFQOLMCZ6TZqmJbK9ICpg0FIDBH8ZkjxgZRedFbC3eumxXrO8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+wqTIuQOiqNmr2xJZRF7H9EZwbntUi/sSCczTF6sC62P4HSm/4
	5BrBx93WHYo8FNlXSyXb/YqPzy+Xl1NCMBMrfigltUnFuUa7SAPq7j18wUWy0NFN82EkULiUnjA
	5miIX7t+nddiC0bZszsa0aI0wfeIWw6u6s9NbrqsdmQCXconG1ObJ6n5S0B0=
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4fcb:b0:574:82cd:a022 with SMTP id
 5614622812f47-57741c1eea6mr2354609b6e.15.1794978259303; Tue, 17 Nov 2026
 21:04:19 -0800 (PST)
Date: Tue, 17 Nov 2026 21:04:19 -0800
In-Reply-To: <6a8bd0a6.91706f20.16b6e3.02ce.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6afd31d3.8f566acc.2517be.0016.GAE@google.com>
Subject: Re: [moderation] KASAN: slab-use-after-free Read in uprobe_mmap (2)
From: syzbot <syzbot+1340ad4350ad43394c10@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mark.rutland@arm.com, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org, 
	rostedt@goodmis.org, syzkaller-upstream-moderation@googlegroups.com, 
	zafir.taufik@starlabs.sg
Content-Type: text/plain; charset="UTF-8"

Auto-closing this bug as obsolete.
Crashes did not happen for a while, no reproducer and no activity.
