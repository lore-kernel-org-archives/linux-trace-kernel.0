Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE9A1F471F;
	Sun, 15 Mar 2026 12:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773577230; cv=pass; b=khQMDeWhzI56jFgCXXWfmPhABbuosGh91VOYJSPpk2xXYChpniZV0DJtpMWXPGTJ+dtK2pp34FEe8dtuzt+yu5xZ9bSpnwpItPQyuE5JL7vLXkvk6bZzJdKCqURbsi1rN3a15FTL0b6630TR1OI5YM7WjnczeVnHgKQEk0i/MY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773577230; c=relaxed/simple;
	bh=Y9mfWQWziz20z1wZlyGCqiydfBbJQNFNO/oywEYrkow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ilAaS71JjbCRcrJ7qam+urhAi76YSiv2IQF7ATIZV6EN3pweqiijxR0TUjs+EqFEKWj6GmCVYT81JHjKw6iK9qSRE1o5+sqGwGAY4fiHUxMqJfdWf4CwwXkS/BxQKAiYFBXvQkR6ldtEpSY3QccFVlqnNS9p+BdLGZAn/LK2WvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=b/B3bKJ5; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="b/B3bKJ5"
ARC-Seal: i=1; a=rsa-sha256; t=1773577220; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=bF31zOarh15tM8Qt2y6/iTdjSjFrfXVQ+L3n2Ch6lUiyLrl4rYnaQzTv7ai7mfL2IH+JPzJJZIs889raOWxfUt2KfIft9cIt8mgFhbVZ8o+k9HV6q6FSnf4fbJS7uHbSkSVsMLfluEp1gMkGsC83VRM/cB9oNoWmqQ/c/ww642U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773577220; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hXgtMivk2FUkBDZ0ELim05yAd6enb/8iaNS3/idzO40=; 
	b=GJNAtDv2pYOJdGxhU7oVcDAJNxlNU+I4APQWmlERcbTuVPbafA/6To16GHPuJA0jznEJHWeAzC+OU0t2kzw8T+c9FStuOAhBM5PppPsIeiNu7pSH+YYKRK+OGtsfftyhHtjLSzJKX+kJ+cHWGFUowUg0TwJqSIosO7vD5OIQC0g=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773577220;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=hXgtMivk2FUkBDZ0ELim05yAd6enb/8iaNS3/idzO40=;
	b=b/B3bKJ50hUp8gTfMgaZrqX8LuKFRcvSidOFCv2ZmEssYGlFn6IP5ONMT5ot+04Q
	YntrImmDe+J0dQ1CPluZzQ3rdXEhjbgjhXKGXaHHf2PiKvPZCoTPQZhYJckOSL0TDXl
	HPXDkNq85Hg5VKvSGXaP+QJdMnd8z8sOHodPQmGk=
Received: by mx.zoho.eu with SMTPS id 177357721736357.63884775573274;
	Sun, 15 Mar 2026 13:20:17 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v6 01/17] lib/bootconfig: add missing __init annotations to static helpers
Date: Sun, 15 Mar 2026 12:19:59 +0000
Message-Id: <20260315122015.55965-2-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260315122015.55965-1-objecting@objecting.org>
References: <20260315122015.55965-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

skip_comment() and skip_spaces_until_newline() are static functions
called exclusively from __init code paths but lack the __init
annotation themselves. Add it so their memory can be reclaimed after
init.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index b0ef1e74e98a..51fd2299ec0f 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -509,7 +509,7 @@ static inline __init bool xbc_valid_keyword(char *key)
 	return *key == '\0';
 }
 
-static char *skip_comment(char *p)
+static char __init *skip_comment(char *p)
 {
 	char *ret;
 
@@ -522,7 +522,7 @@ static char *skip_comment(char *p)
 	return ret;
 }
 
-static char *skip_spaces_until_newline(char *p)
+static char __init *skip_spaces_until_newline(char *p)
 {
 	while (isspace(*p) && *p != '\n')
 		p++;
-- 
2.34.1

