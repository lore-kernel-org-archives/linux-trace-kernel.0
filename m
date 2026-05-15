Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D29A47ECD6
	for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 13:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853552; cv=none; b=p/IMxs1PtQcuXvmhsExZZ3WLdMmPT+x1nYNJkbIYucQQ4SyRw4MV3S1CTS5kBZWJUqPqGyTkA77j4/SMIqefjQ1QMA1395qYXVe5Vja2ZHMriDXT4RqJkCgxbZKEOlT7tHCLH7nOVFjpBcU+aleQu/4BwnJ+xaEuCUMANc9SoLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853552; c=relaxed/simple;
	bh=tVZj1+966VqX+wAXgGFS+7w3EvvAUDuCPHW8H14LHLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZP3+wcWyEWoiLrQQIkH0TF1ZMHDs6andP5yjR5JDPOmQNhTN6I1iW5MmfIHcSyPgI3os6jNIvUqOucyD5Ok4Uy/JYk+lGeX3zWCvnIc4gwNLtx3nNddzKz+N7Rs+LPR004ZEVAPhp8JfMqcfPzJINlco5KJhi0DRPHbhHEIJro8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=teHeFy7W; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="teHeFy7W"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8acb3daf2aaso122070196d6.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 06:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1778853549; x=1779458349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uHdVr+Knu51ewWGCsREiTmFjxqZ/k2tepG9i/Vxx7HE=;
        b=teHeFy7W8y/lbW24oml6pKJ5BHeKsCsWZ3PDqzpckir9H8b23T2p/DN67HXL3q7pg8
         4aJZ6xFKhnWN9kndBfFry8uKmZRZw8WETF9JpckSyE7N/f44xg5blg/dP5isuJO3R25n
         KviXn7Y7Vf7Cktn1LI272gsNpg0iCV6e6DSR7wZR22f1jjxGu15vEFBnqA90AFK1hGsS
         fTfTbYSdEsJ1piFcdBNXZB0YTfQb3EW4fc/WIl43ihxwlkQqrRtYVwu3yUbvbeSeQ04/
         lShZvjviQEwwyMtLBgx9iTpNioAaJtOcWt1URmC1bdhlvJGaLS0dajoMhhKb5N80TyeK
         gLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778853549; x=1779458349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHdVr+Knu51ewWGCsREiTmFjxqZ/k2tepG9i/Vxx7HE=;
        b=GF+LWo32L53hDvsaKeu3XNp31ehk5Za/vFjSK5K5ImCxK+LjwO5ThxqRl3fEY4XdDm
         oPDSsroa2KsPhV0lThWFwjpkOs4iqZrVDWl+dbFN7L0nyGljT/je1YdIjdT4Dkiu+57M
         LtnQ1+wxoJC+/DO35pssD1Y91BTjKsH4OlQVHttgk6U/2VCmX/iPLextcSsxwPKD7hgX
         Avrra5ZdphKF0IjhXI1JqeuGs7x6URA3nz5RuHlH3Y2M70VDRAgWYpweE1iaQL/p1bYw
         5tBXCdPlfXNbC/EQIMQak3+MmNjuM0QwmgEYrjN0rHKxNksys2n3fECabjqRvRGB0BI0
         i/8w==
X-Forwarded-Encrypted: i=1; AFNElJ/iM7Y02VqnXzdU8d35LJa2hvcdqM/tX8s1z/FHCrvLo79CYH6zbFXSBc1x1DFa/1c5v90hZ1Foof9Y7mwuLQyQNFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLl9zIqEIkUzekePnAvGUkRrsU76GkyNMovw5M2HUogc1CDljK
	aACMGuH01GtIYUg2q1VuaMdsvH6M8p5/FcgfTW9CBUpAcLAg74KrDkgGegQXOp4G+AU=
X-Gm-Gg: Acq92OFKdon+Cqlz5/YV6hY0xwrQuRrROAGPCKJZezxpTzuuwpefLPEiwIujRfHMbAz
	4jqGn4ZXaI1iyslRtqwfgtGGxLdbmx8yG6kjJF9d1VpvWUxmKl2huSM8c/AtW3w45Cv2bbT9oGh
	BfkqMcklTs2DW4TJKAR5QE4Gc13h4ohkrw6LOCH8WnsdcNqVwVNhwD07nZlbZ5fvpbivUU+TRQV
	NSi3xAD2voiqvp9qaxORXII3+5Q/eUJqG9jjISRi97MTAb/Om2Kx1GHN4LeQ536f/X0paFdj98s
	+xXKFwU6DWSu0xhtk2iyhj8J4x4lSOP91/jbly8HPxfuVUSpv8yeZEfs//nGEhVGDDSl6blw2mL
	fVEYIdrZIePFsIfbKNBumKRpa5J3vcTaDVgNK2sWcMvKhrwTaFJB0gCjqUF6HI0GXRsFgJHfB/2
	R60eve/PVrTRpJoh8RnDBjitaxkEWG
X-Received: by 2002:a05:6214:3f86:b0:8ca:164c:a851 with SMTP id 6a1803df08f44-8ca164cab11mr39494576d6.41.1778853549278;
        Fri, 15 May 2026 06:59:09 -0700 (PDT)
Received: from vinp2.lan ([2607:fb92:1900:6734:902:ab48:6190:9c1e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90874da6dsm52910696d6.9.2026.05.15.06.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:59:08 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 01/11] io_uring: Use trace_call__##name() at guarded tracepoint call sites
Date: Fri, 15 May 2026 09:59:03 -0400
Message-ID: <20260515135903.2238731-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vineeth Pillai <vineeth@bitbyteword.org>

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Original v2 series:
https://lore.kernel.org/linux-trace-kernel/20260323160052.17528-1-vineeth@bitbyteword.org/

Parts of the original v2 series have already been merged in mainline.
This patch is being reposted as a follow-up cleanup for the remaining
unmerged pieces.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 io_uring/io_uring.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index e612a66ee80e..1b657b714373 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -312,7 +312,7 @@ static __always_inline bool io_fill_cqe_req(struct io_ring_ctx *ctx,
 	}
 
 	if (trace_io_uring_complete_enabled())
-		trace_io_uring_complete(req->ctx, req, cqe);
+		trace_call__io_uring_complete(req->ctx, req, cqe);
 	return true;
 }
 
-- 
2.54.0

