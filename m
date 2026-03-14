Received: from sender-of-o53.zoho.eu (sender-of-o53.zoho.eu [136.143.169.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3B839021A;
	Sat, 14 Mar 2026 22:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773527686; cv=pass; b=qSf+lHYqdAchHM6FFrEbTo7INalCWQzgdg8m/JrfqctKqj2OlaKM8uq1UQcyIlknW34EtDoSfepENg9fk6csLD0Y+eLfPF0lMBWqhjaGz/g++xxKm70XeRQudGyRb3ewR7UShkwLO1QnT74yyRNUodSw1Qyl1hAghG7OQLNGnFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773527686; c=relaxed/simple;
	bh=4hvIdsyU/LaVH9Cl+UZr7yonHlF2t2i6TR6b+vGdeIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i0+OEusrliEzl/rADABiKCFSLROpXXr49cmno4xeao+DCc/sWFqWt+L6DRR48TZDRWxC7+fLngniX0tJlwK7SMzDio3inMmviIeHjKnCvxK5rYHHxJER9gu6V3s+Ze1k2RvmJG/j1SDL0dGI6e8HiE6j5zQFzln1eb+tQHZuYLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=DQJMKYBG; arc=pass smtp.client-ip=136.143.169.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="DQJMKYBG"
ARC-Seal: i=1; a=rsa-sha256; t=1773527677; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=d3pbmz6jKNEuFw2TnM56puEBtyiLuAHLR+buneMjD+vpS6fFO7bvUbS9mP2EyYRy+r6/I5aHYOrjh56R5lvtG2anRpNPzANeZCi2SbGuNp4+kYAzma5y187ca7cpSZ2w90bLEpw6MAYXjmzF6fzr98nhigOP0vLh0DLEHN8vdZk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773527677; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZmbCE6oHGMaPEvykEN4WTjS/8fklO687Fi9eR6U7ss0=; 
	b=gZI5yvS9NXqEaE4j+fAqrrx3qPlDMs7wOjYIQArXzErg8gUogljAZs9BfWR0WFa0rcfznTQPJMruC1NPv3yZaZCCKzEwB8PYx4csFHEWRE7AlRXY33xgJObCKNB16KqL/MSDh2X1ZFBoe+XPf4Kxx9ZRTj3gI9oDlDsO0Y5OiJw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773527677;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=ZmbCE6oHGMaPEvykEN4WTjS/8fklO687Fi9eR6U7ss0=;
	b=DQJMKYBGdudBXWk5uv32ElWLqzQI8xQqFkstwSBoq4q/m/1HXwG52IsmWo8CBu67
	BfzGEPX9TTumk9bvuRS9w6YWZ110n1iL20JfEZ7DJqsawJxg9bdfk3s3mv79HSJRlsg
	sAmnihCo1jNbQM5xveLPzt0CFKTcjWEHRR09440Y=
Received: by mx.zoho.eu with SMTPS id 1773527675504893.5611690036359;
	Sat, 14 Mar 2026 23:34:35 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v3 17/17] tools/bootconfig: fix fd leak in load_xbc_file() on fstat failure
Date: Sat, 14 Mar 2026 22:34:25 +0000
Message-Id: <20260314223425.142966-18-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314223425.142966-1-objecting@objecting.org>
References: <20260314223425.142966-1-objecting@objecting.org>
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

