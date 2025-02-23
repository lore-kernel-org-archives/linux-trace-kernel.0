Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0B73FB3B;
	Sun, 23 Feb 2025 07:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740294096; cv=none; b=Ro0IZwnz58NXmUwSdJFih0Z5sXZ5Qsjsf7pSezCQa80k01PozS+Ve+n5MXQ55ml2yrBS/b/30Kj47OTIuS9gMg58r/zUnXByCuPe+3U122GtTfrFNNLshR82bw1/Gk05aigtmwDOjxMLb5i9I4nKhgqjr1F1LX4f3aCEphZljVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740294096; c=relaxed/simple;
	bh=iHcM+418cwGbIFvJAKJ3q5m+qdZ1GMm7O/kw8C9W984=;
	h=From:To:Cc:Subject:Date:Message-Id; b=rUI7fK6wD2vwVLZzfXpw5kSoEy27j7YBM6b0aokm1sxmKqS/m/0nOwuIn8jjQRAEJkQqhtW9Huk1NLCvyUfSQcBARWlgtBmurVe6p7yq1zX0o2yT18kpeGOCgVligVtHkHcs5oa8g74n7SzECj/Arx0heLHEVJEUdEI7Al1twao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=d8JGqOXV; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="d8JGqOXV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=xnxr8ajCrGei2+iYa1
	7nwH0TcnlFuD6GY0BMpH5KR8k=; b=d8JGqOXVwB0k4Pba4rmLnvNpLuUUhd+fEQ
	mrlf9vpxzz+ZUkBBz1OBirwF2t4xtRYwoi73LO2O57wgx8X1WkCSxvVxFoEc4FlG
	SjqW4NnnfgRGegvIgzC9q4js1so+MOz/bwzzgz18hfMmNKLKBV0vV2SW5x5/m+R3
	uXupU4FM8=
Received: from yang-Virtual-Machine.mshome.net (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3H0G0x7pn3PW6OA--.65050S2;
	Sun, 23 Feb 2025 15:01:08 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	Feng Yang <yangfeng@kylinos.cn>
Subject: [PATCH] ring-buffer: Fix bytes_dropped calculation issue
Date: Sun, 23 Feb 2025 15:01:06 +0800
Message-Id: <20250223070106.6781-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3H0G0x7pn3PW6OA--.65050S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF4UAr13Zr1xKF1xWr4xtFb_yoWfKFX_ur
	95Wa4kKFyUCF1DWr4xAFWavFs0k3yIqa48u3W7tFWUJ34Yvr15tr4kAFn3KFWDWFZYgr4a
	qr45Wr97KF13KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbvtCDUUUUU==
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiTRz8eGe6wyZBMQAAsd
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

From: Feng Yang <yangfeng@kylinos.cn>

The calculation of bytes-dropped and bytes_dropped_nested is reversed.
Although it does not affect the final calculation of total_dropped,
it should still be modified.

Fixes: 6c43e554a2a5 ("ring-buffer: Add ring buffer startup selftest")
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 kernel/trace/ring_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index bb6089c2951e..510409f97992 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7411,9 +7411,9 @@ static __init int rb_write_something(struct rb_test_data *data, bool nested)
 		/* Ignore dropped events before test starts. */
 		if (started) {
 			if (nested)
-				data->bytes_dropped += len;
-			else
 				data->bytes_dropped_nested += len;
+			else
+				data->bytes_dropped += len;
 		}
 		return len;
 	}
-- 
2.39.0.windows.2

