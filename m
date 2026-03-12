Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D113D891D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773341124; cv=none; b=SEmHomuCzPN6FjYWtjYfcSqSMVBAJn/GDLNuhI3AqMZuOr/njRnq4yAI8g7A1RZgxXZVpNLnf9lkugSoimcS3E+zq2cmzGwS/XVZ9nBgd6cwGL6cyQcyBYfO5upZot1w3CN84gIG9sHuoy9kYzZuMyOcCNG9yWRL5ZgFzMCjpfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773341124; c=relaxed/simple;
	bh=+kMlSxjMZoglOsCcAnI+So4oVKy/vFvPGKu4SmIoT/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AyZwa02lh9jIGniwnN+FACEwAkfyweGrqWNYzPDSfSPoDB8/WmwIe/MiK5FbNVX4iytBar/rZNlm3q571buPBbAompRSdQMcWTS5/5H9p2d84tRace0HqKVLf6OOPPzuK9fQVkhHupi9NTvVZ+wdl2a5v5YpTL+PhuVFDoeniSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jACBKLYj; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jACBKLYj"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-38a3f6da741so10237661fa.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 11:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773341122; x=1773945922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vuk/jw32c8PNpTwL/uN6PztjY6W4Zj8CeSCt8quW+80=;
        b=jACBKLYjbuGswfE5RlLyN1mB5nKuMnnQzTgBQ7TzsEH+U+UyF71Q/YQl0gZUfjwcRx
         3mOW+CEyp1wprGPSA80WhqxTu/sErRBVyhnhiigHUrwwdhqtyr9ghZeXKRa+McL8rwwz
         IQzq1CbjBlstSrVaaifIyXLwl282/1FrzCRRysowYNcFzSHc+aIKuPcP69NJDnzNuzFD
         ET00TK7CWCD8mpMIcYidBVg8ztVbLsE+BlPuGspQCHCwJ5th9UzNXZr4g+W18NhVojyg
         3P5jnab2om+v+QGq0z9hOuUzmrl/SJLiqsiJSIwP4QwJpkrIqED7uhh298zewFps2xGn
         IpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773341122; x=1773945922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vuk/jw32c8PNpTwL/uN6PztjY6W4Zj8CeSCt8quW+80=;
        b=sbOqGeYG4keIZOV+QubdZ0IEhUDtsd1fNFQ7tfHApGc9cEvlrZ5C0PIAFWLWaRoSk6
         JL4oxkv6H4MpMKR8NJzGPOJftjtKi6GoqqMTd/S282YmQezZzrxWw1kSEHxIojoGDbkA
         yuTluFXZ/trJNPU7o8S44gO3pDydq0IO8QhROttbAWNx0W6ddLPa30KLCX8qr6IDUlwS
         Je2RB2R0HjTxnWo7yjnRZlS1Rg7cdm+dqjxPg4ZbH8JrzKwCZKVKj0qOzfLG2hcHMLJT
         bkbOboIoam1jP2B2K6whCal0VhmnlWnMQsYQPqZQXVRBDcNvKI6guYg+77C1bH6vyVuG
         2IxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXMi+bd6SzF8EXuIte6v2p9auw3fHf0ZCH9kq+jgyKWL0nKCl8AqUaTpdFrL3aUrWrq+86dM2WWR6i/8WJgq8XlSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf6141t7f9GuZGztY+FmsXComIOomNCh0/GjMX4yQPxtfsx6os
	nxwn1r7g5zQWTvzHwDf3ZL9uBB/MozFVPXAPmlMDcXlQM1nGO4LsprVDFNavBkIq
X-Gm-Gg: ATEYQzzhIUCwCAKY3ycj6bfWdN0fr9vd+n2NrpwmAFsN2kORcFFlQgxboobTSOqdwxO
	YVdFGNONVTIrLJmAL3IuxNQuUyNd0zK4QWRpBZombQbYV8F/JQRdgvribFuH/0JoRkIqk16GSa9
	3qRbuBxRSh+sSBp/B4KXnCapTsx2PvBPQRLiMZL+hy5AUvxegs6JH3TjjlN1Dv+t6sGH/OU74PW
	ibtUpFun12gFAbyr7rIoaXqn+O/MFj7Ip9WyUfQsPBbdvayHgwi5VRB9SKE2hAexck4gneDXC5N
	rhnmnlQIDdOlMNa2BB3tOIt0f0Fns6XRPlWqWnXHzyN34q5hr4Fy13vH+G4HiktJUSp1hTh9rBx
	0jaKSBcLdHu1xZclNsvmK2W1st+KGXnzsHmpyKY3ws8kUVBr57qMWZu4POiOvHrNXeAm+eyoQyB
	Nba0ER4KQeLLWXmbnzKm5fXpU6Hp/Ms1ihRoZWSZzdAO4WL5TZYXbh0dN9VZzuTLjLwNpCjsU=
X-Received: by 2002:a05:651c:210e:b0:38a:27e:b904 with SMTP id 38308e7fff4ca-38a8965822cmr1225031fa.4.1773341121502;
        Thu, 12 Mar 2026 11:45:21 -0700 (PDT)
Received: from ubuntu.. (static.159.107.27.37.clients.your-server.de. [37.27.107.159])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a67e7b64bsm10382991fa.43.2026.03.12.11.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 11:45:21 -0700 (PDT)
From: Josh Law <hlcj1234567@gmail.com>
X-Google-Original-From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Josh Law <objecting@objecting.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 3/3] lib/bootconfig: fix snprintf truncation check in xbc_node_compose_key_after()
Date: Thu, 12 Mar 2026 18:45:20 +0000
Message-Id: <20260312184520.24399-3-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312184520.24399-1-objecting@objecting.org>
References: <20260312184520.24399-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snprintf() returns the number of characters that would have been
written excluding the NUL terminator.  Output is truncated when the
return value is >= the buffer size, not just > the buffer size.

When ret == size, the current code takes the non-truncated path,
advancing buf by ret and reducing size to 0.  This is wrong because
the output was actually truncated (the last character was replaced by
NUL).  Fix by using >= so the truncation path is taken correctly.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 62b4ed7a0ba6..b0ef1e74e98a 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -316,7 +316,7 @@ int __init xbc_node_compose_key_after(struct xbc_node *root,
 			       depth ? "." : "");
 		if (ret < 0)
 			return ret;
-		if (ret > size) {
+		if (ret >= size) {
 			size = 0;
 		} else {
 			size -= ret;
-- 
2.34.1

