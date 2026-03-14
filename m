Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9D538F634;
	Sat, 14 Mar 2026 23:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773529337; cv=pass; b=NL2UagwU/tVwtZwq5EXoBdaeK6SrrR35VGfpynGrz/iL7Yq3Zbq5xrK1ESc5RNwEhfjmzBOuC6wLZ6iq2wHVyr1QdRNueao0wLlwsZWw+ItfMj9S72C4VZRYJDIA7ii2+1AmcY/0TpxzI1n+/eEq+8zKcc6K/ZQlufUA4+M4tX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773529337; c=relaxed/simple;
	bh=4hvIdsyU/LaVH9Cl+UZr7yonHlF2t2i6TR6b+vGdeIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UwwGUw5jU9OTJqT+4Z56X7gdHT5+DTDEP7DdNSP77QklzDZi9USCKtNUBRtiCqf2UGfUktGEavuHMcV9gI8HmIm6iXvx/0brw20Kz2l16p1qksyXUVPwAD/+xaCYyEv9GII7vPLhqUajPr5/x8TUKW0r0i6gIDHxTzgAXnFhAa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=JW+ZUJGw; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="JW+ZUJGw"
ARC-Seal: i=1; a=rsa-sha256; t=1773529329; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=kMXz7kgQEJpPvK/4x5BTloXSp1BIlCKhpRwJkvhjjEN2WTW3/CN3yIJWLT4bOkw0Y4Z1MmG6Cai7xXRNogXX8lanZjgsk30yLQ+xkCPcJk6wRN8/vkZFPidIbIR3draQLMwNJheHXn6/qLOw3gB6NBZwidW/fyvd3xeF0lVeh5I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773529329; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZmbCE6oHGMaPEvykEN4WTjS/8fklO687Fi9eR6U7ss0=; 
	b=AeCEUDTjxsqdSXk8rXnrI0P3df4aQ0QOIKco0gd8nRHJumnBKinitBwj6GHwgzxGouuXTUkyc6JYP8f1OqoXEazU4QPwk0SFPe+D7szAPf198LisXoRsBc+7nmJ0jNxloQg5VTur1+VRIMUIy3kog6JyDc3QGVUxsOBiIdI8b/8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773529329;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=ZmbCE6oHGMaPEvykEN4WTjS/8fklO687Fi9eR6U7ss0=;
	b=JW+ZUJGwDqjG+GAWkofmh90GOLKs6FS/c/+DUe335Z92TLaumLKA+9dVQ4EF5qfW
	oHtPeJDnXvJu27pDIl4Zp0x2UQ4ykF33neb1dCFrh1mG66nI90J+JnqhdBeSXZz8jB2
	OzWls6VtvLzZYsYEI7IeuqmLtrGI17VieOguguPc=
Received: by mx.zoho.eu with SMTPS id 1773529326700324.3068439281609;
	Sun, 15 Mar 2026 00:02:06 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v4 17/17] tools/bootconfig: fix fd leak in load_xbc_file() on fstat failure
Date: Sat, 14 Mar 2026 23:01:55 +0000
Message-Id: <20260314230155.155777-18-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314230155.155777-1-objecting@objecting.org>
References: <20260314230155.155777-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

If fstat() fails after open() succeeds, load_xbc_file() returns
-errno without closing the file descriptor.  Add the missing close()
call on the error path.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 tools/bootconfig/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 55d59ed507d5..8078fee0b75b 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -162,8 +162,10 @@ static int load_xbc_file(const char *path, char **buf)
 	if (fd < 0)
 		return -errno;
 	ret = fstat(fd, &stat);
-	if (ret < 0)
+	if (ret < 0) {
+		close(fd);
 		return -errno;
+	}
 
 	ret = load_xbc_fd(fd, buf, stat.st_size);
 
-- 
2.34.1

