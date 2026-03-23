Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7230D3BED7A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281698; cv=none; b=gF4FdnpDqLidJ/MXUVTsvGzu49wxomqopql7rdiOBljG6PhAJLja83EPr57tUW+mkdXsiYBlgTagu1MnA+jPifYZKb1xqujn4mXUG+m8pjRhjopUNuqIKBYfEdCsL+pV2zl8+xwTEy7jBiD8u0i0deeNrcqfdBbunU83TMumdJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281698; c=relaxed/simple;
	bh=MZnmVAxJf+X6cHJOBPvDd6V2H0nUoF4Hno5Kv0ax+0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYuvZ8kSE0PRggW2NF1zCC7y4icy7e0Y0pdZLOWM7ZvV9WaFHinRCA3wDLbZMR3yDLjAma2Tb9R9ahoUSSXAuxadycZVNiAF66gXh2H+9j6K3mBNeQHUCJdiJmA5YMEac2OTKiiqEzD1Yi3QG4my6dtinIcZ74F64a1JN8vrus8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=pObiQh1M; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="pObiQh1M"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-40f1a1f77a6so3079826fac.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 09:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1774281696; x=1774886496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hqD+qM2Gta/bzpbgYsOccfWP/3yL/YGd5soFmEVY9Q=;
        b=pObiQh1M3Uzo476arwskTOTfu5mJRY56RVmXEgcOiYczx3bT9M+dzcWDX9KL6jw8M0
         xRVDVuQiCyzR44SPeMc8FFmjpR4YmaM6TqtOwPhBzHn2mL7+nSRbGw66qF3PtJ2KHJIN
         a1oPZqCgFkqoZvMHQ7KkHftpbrnB0sgX1rAivw3LXstdsrlTzB1r3IzUj0lCyXqtgB6v
         GiXbW47ihgEKqUK2XjPRoaGfwhdNWaaGUjWJcwHemf1PMQT8R+94g5oockhCCuQwit5N
         HBP4bkh/wFW0KlysQ+I5PwKWW3/s7gMAo4rqIBPtLXBCgw/7gV4voYrOPK3KtG/G4EBA
         2vyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281696; x=1774886496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3hqD+qM2Gta/bzpbgYsOccfWP/3yL/YGd5soFmEVY9Q=;
        b=FuH+L+H10QEprxatFXdPqLSHCoWr1ARJ4U8cRH8JzqwdJ105g0ZcTD1huhewfYeQv7
         YxnjWpvW7sgZ7t+KdvGdCy/557uW/bm0LmfDOnR2RHADcr/UaT8D02YMxb2mj7y0V+1G
         NLqU0Zd9frG1h45TkUTTGe5c+vXBD5hMAl1kLZtHS6SC98hGoaqvr8ZaboenhRNudacP
         e1Bdr2iGlM76FFAwfbXSkjUZo1MGuN29nscB1KqiHoosK7KxoumJHoENK3t2WBr90Pr4
         BO4MCCNs+si6ZX7JrMRWpjkCQAXsDXKZGfY58VXFU6BUZbaIjtcYy7IMQL+JQ4jGfLQR
         n2OA==
X-Forwarded-Encrypted: i=1; AJvYcCX0vH1QdocQHwRc95ZLtycUZJyVcYGZ+PvkVkyZ5a9WRJ+aXQhEyBBl2QELAoBccUgL2/Vlbb04ukCinMDONRD7T5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLiEA9bAfHtfU0yGDF2LYuA7RPr7Yb+rxHHqze+rTQP/dYZzum
	ggd00K76kz/djcPnuFVx5q+LxacGvEqJjIxL86CY0hGUp4cxZvagSecszCGjaF3uts0=
X-Gm-Gg: ATEYQzyMmbqJ4S/bLSBNQ0SEjAgAecJU+TzG0laTdNHSEzJ2MlKpO0ki9pvBgKqhDYQ
	7nS0dGiaMDTeWi0t6umn6J+WDxdZEELIp8H5FTenmLaur2Uh5dUytfkT+qXaPWWL3zJmCNJqbmk
	xq4UGdX3cuWsbHKaC7AVVbXuPXCxxLRquO519bcU1WxJAqFbGgwl3Kx6rIE85mCtXdkjD/6HDVk
	u9aec3/sjMPghN69Qt0oGcbEeCOm8KV8US+Yq3hc+HxhiI836d3XiYJgD1YmfFadPYlbj3RT1PR
	ORpqZxiuyZ/vaU+mLYZ2CDFw/1/YHnLdwyHYml9NdcQbzJ79CS1hdHFP2QfkAXRjG+EoqUKvo9e
	JdCPIHHQdl1jrRrIeAyUbZDklEiiLcbEu3gk6ew40e2zzV8ExCPsqyiowFaMY8S9kWKMjpT/JaM
	TOL4ox0Ks2Nvvnl9Nlqyrij2GtIiAdnKPxExv8H0t23chUo0Crr4V9cc/m7SI1ZJqnow==
X-Received: by 2002:a05:6820:2085:b0:67b:ab68:b5ed with SMTP id 006d021491bc7-67c22f2703bmr9958074eaf.21.1774281694519;
        Mon, 23 Mar 2026 09:01:34 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9088df1sm843364185a.25.2026.03.23.09.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:01:34 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 15/19] btrfs: Use trace_call__##name() at guarded tracepoint call sites
Date: Mon, 23 Mar 2026 12:00:34 -0400
Message-ID: <20260323160052.17528-16-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323160052.17528-1-vineeth@bitbyteword.org>
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 fs/btrfs/extent_map.c | 4 ++--
 fs/btrfs/raid56.c     | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 095a561d733f0..9284c0a81befb 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -1318,7 +1318,7 @@ static void btrfs_extent_map_shrinker_worker(struct work_struct *work)
 	if (trace_btrfs_extent_map_shrinker_scan_enter_enabled()) {
 		s64 nr = percpu_counter_sum_positive(&fs_info->evictable_extent_maps);
 
-		trace_btrfs_extent_map_shrinker_scan_enter(fs_info, nr);
+		trace_call__btrfs_extent_map_shrinker_scan_enter(fs_info, nr);
 	}
 
 	while (ctx.scanned < ctx.nr_to_scan && !btrfs_fs_closing(fs_info)) {
@@ -1358,7 +1358,7 @@ static void btrfs_extent_map_shrinker_worker(struct work_struct *work)
 	if (trace_btrfs_extent_map_shrinker_scan_exit_enabled()) {
 		s64 nr = percpu_counter_sum_positive(&fs_info->evictable_extent_maps);
 
-		trace_btrfs_extent_map_shrinker_scan_exit(fs_info, nr_dropped, nr);
+		trace_call__btrfs_extent_map_shrinker_scan_exit(fs_info, nr_dropped, nr);
 	}
 
 	atomic64_set(&fs_info->em_shrinker_nr_to_scan, 0);
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index b4511f560e929..0b5b2432aedf6 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1743,7 +1743,7 @@ static void submit_read_wait_bio_list(struct btrfs_raid_bio *rbio,
 			struct raid56_bio_trace_info trace_info = { 0 };
 
 			bio_get_trace_info(rbio, bio, &trace_info);
-			trace_raid56_read(rbio, bio, &trace_info);
+			trace_call__raid56_read(rbio, bio, &trace_info);
 		}
 		submit_bio(bio);
 	}
@@ -2420,7 +2420,7 @@ static void submit_write_bios(struct btrfs_raid_bio *rbio,
 			struct raid56_bio_trace_info trace_info = { 0 };
 
 			bio_get_trace_info(rbio, bio, &trace_info);
-			trace_raid56_write(rbio, bio, &trace_info);
+			trace_call__raid56_write(rbio, bio, &trace_info);
 		}
 		submit_bio(bio);
 	}
-- 
2.53.0

