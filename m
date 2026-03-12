Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0128D3CAE67
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327957; cv=none; b=lYjVBpq1eG+dAfBA3kM06fQi6vEsiDWmgmypJmCZs+1Yxv1jeR+5/lot/A/0Os6hWn8XgWB/e1NJ994pqFwKcjGDjsA0pHBoW0IiATEFp5m6pS4cRMkMpj+H+JFq+xaAck9CPc2f18Pt/dzxls1mDyizQgt5vJI3AtmSbJXL2BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327957; c=relaxed/simple;
	bh=gX9HruxmlZYlkDGpy63m43c4O3drvYXyRfbnYeF1G/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fU50gaL1LjudYoyFFwqym+Xe5vt+Iz1Eyfvf5p2Gc293/yoe8NvDG2YjRptw8yfZj811HMnbTFk55xQ/vH5aAAiTtvH4VaKKPka+eLhGU6b5XyvGgcaDHaQjSnFwXjmYKN/Cv3DdX9xG5utTG48yfR614otBI9QM6wev6cyOzg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=ONE0YndH; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="ONE0YndH"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-46704fbf62dso761303b6e.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 08:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773327955; x=1773932755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7eLdAjWqLkV68ejMBa/WmrgRe56JAh9Yt/CFnE5wNAI=;
        b=ONE0YndHHmoHQeJ/hSb03jI33jzb9LTf0AeZ1D2tGi27r0lP7FN0jGMf88KLbFNvQb
         +5pEkOlq6kC1JCa9ZJOktDZuITsoOvA4rIUuF8BM4Z7NvhGhkzcer3gUYS3UG/it3pPW
         2AKx4w7kgfd/SI0FHVL7XA9lDDKdHx9XVXhgzwkG2S7lLvUjaDDT2S/+r9m+pTxiUm2L
         kApJp/QjwBGlTX7fYU7IIVrKeGj9AdE4dTjZBo72fykU1kdUDpz2tn/FkQCoVR8KmjgW
         sFlT0zbx2Ls81WIYfa96shPxx6FKvBkBWkhqQJm9qlGUyHDi6S32K1ZCCfYEz5x8EI34
         cb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773327955; x=1773932755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7eLdAjWqLkV68ejMBa/WmrgRe56JAh9Yt/CFnE5wNAI=;
        b=IxsOJBEa/ABxxmAtnxWSRqqHDRME8v8rOEmgJO9SjK1UsTocpayHPrZsuWEVdZ6xWf
         1oFSNrllsw4O61stEnlqcqZ0UF/1vhuX/BaGeK2IR6dvhr+bHjx2yI3nlY5eezCzOZjV
         GC+sdtd9s4Q7xmSe9iTpgKNDErD6v5pYtJsHoS47T06tlQoLtoe9COUcOOvUon13bfIH
         RXoizUTl/LNX8WDQJArUZgm7mDqJknf1Vf+O/YTXYA2f3rISOuXYPMrc6gqLUAoUiMH7
         Ni8NTK/3yqF3i4GmZFs9GU9dIaXglFxHb4MLlx0cGwgR8yoSZkfRD6elJbqs/qWMw2QW
         AjZA==
X-Forwarded-Encrypted: i=1; AJvYcCW7yx5ZX9ZIV28K8KyNQPzRicgeKTT3QM/JeWu6rssZPe69yqhU1oOFDSGMLWPC5+B5vErL63D3Gle6lNJTiWZs5Zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHiYz57HgqJxelpEtXTQkQeRwScQV9OkgVUGC6UNy/B6M9xc04
	58ZivspHb4zG4ImUMRBxzF4zwWcA0a7OJVryJrfVZJ4qTVJkaYbCUMO4rZADUMvTuNI=
X-Gm-Gg: ATEYQzwe6QL+eEnEwSe6BUuJ+c5Q8WqpCqawlLETEwR9TXqfyc+KDEDpIn6vka1/eNv
	1X2HDI+46nEA4/cs93HU/4o3NvvKzAIP8UxY7bDEHQgh3i5dumOYkLvFW+sYOyfAVOvnim+fsih
	vaRF719K8Mxxs1yS4JLqhbx7GKARgOH10WOZCW9v/hpTUeW4slRFSGRiKZeGraOjtEUBU8T1wrd
	P/ahet0Cgx20a4JqhhAOejFs24vK+mrJAoahlX7aVpJsdb0lEuNYdbfmne2+FHNV1E6G9hBSa2O
	EwWN01H1MeQmr9FGxPPA15TtdgKy5GzaPcql0CyVwL6ouNMoyBOXoyuu/PmfKGTS2q/pRsRolLR
	ioSsIitxpAS7MDR8JmnLRbDtekZtmXOdCWe8F/lonvO/WeEDfm0YrMczgF6skgWnAIZ4EvrEC3U
	KzBBoSewRnRMlUsBUZEgb70TnDm8+T7O+wWFEQnFSOkX0QbbdTlYBZY8nZVReC8zBODw==
X-Received: by 2002:a05:6808:1304:b0:467:2a6e:ada8 with SMTP id 5614622812f47-4673343a783mr3569173b6e.25.1773327954966;
        Thu, 12 Mar 2026 08:05:54 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76aedae57sm4321776a34.28.2026.03.12.08.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:05:54 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 07/15] devfreq: Use trace_invoke_##name() at guarded tracepoint call sites
Date: Thu, 12 Mar 2026 11:05:02 -0400
Message-ID: <20260312150523.2054552-8-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312150523.2054552-1-vineeth@bitbyteword.org>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace trace_foo() with the new trace_invoke_foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_invoke_foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index c0a74091b9041..42278449d4b27 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -370,7 +370,7 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
 	 * change order of between devfreq device and passive devfreq device.
 	 */
 	if (trace_devfreq_frequency_enabled() && new_freq != cur_freq)
-		trace_devfreq_frequency(devfreq, new_freq, cur_freq);
+		trace_invoke_devfreq_frequency(devfreq, new_freq, cur_freq);
 
 	freqs.new = new_freq;
 	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
-- 
2.53.0

