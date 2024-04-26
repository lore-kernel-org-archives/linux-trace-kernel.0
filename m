Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A4313DDAB;
	Fri, 26 Apr 2024 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714122865; cv=none; b=B5xBhiSTWk90MciOnM5/rU+qXuiL6cpG2izgz6e/TC9Scd3/JwWcyPOANB8BKfNPgBxDIuxwSuRSH6AAyPp7uv0I+Gayod/nsmj2DdTvT7BYg//QkVu610Til0Rbv79iv12JhZ/q2mA8wNxTTdQ2tHbSg2CsA1ktCT/v1g8Znvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714122865; c=relaxed/simple;
	bh=QgmigtmXco4RxQEQVpMpVYHseHWLekm+mdWA7DYsWXI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eDdavNAg2LgPrdPNP7ezrQyTQSl+cl3v+zA5Q4ylQ9ytidOZes1hNSGtQ9gp35zpdHlu5QYgdeIMF0vtVBo6FhJ3pUxYENTGIVlqorPP6PNg6e9Ei7g09nayghYjhMe4d0IZBd/CHIjG0jIcQZQYhfxm0V4ZvoVppCEk2aMf6Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=TMk4iRYq; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="TMk4iRYq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=TcFEL
	qyJxandnRSS6nY1GKmZDqXb6wkOaasu1Qtucyg=; b=TMk4iRYqq4LSYL3hK5ziz
	5jw29gHV65klbXxnBCWIqljAsrsxCaYo7qPfRiTjorOKnoGq0yjdvNYF/WZQuz5d
	AflGDNTsSjehA85TpQzFQIkboJP74CmOrXB9+Ws4ls4jVSUXTYA1AUANFegeOXQD
	pVbWiqAPsDyK2KyY0/6IIU=
Received: from localhost.localdomain (unknown [111.198.54.11])
	by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wD3X1hJcCtmSu2aAw--.64553S2;
	Fri, 26 Apr 2024 17:13:47 +0800 (CST)
From: lumingyindetect@126.com
To: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	LuMingYin <11570291+yin-luming@user.noreply.gitee.com>
Subject: [PATCH] kernel/trace/trace_probe:Fixed memory leak issues in trace_probe.c.
Date: Fri, 26 Apr 2024 10:13:43 +0100
Message-Id: <20240426091343.1222770-1-lumingyindetect@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X1hJcCtmSu2aAw--.64553S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFykWr1fZw45ury8WF4kWFg_yoW8Jw48pF
	s8Krnakr4kGF4IkFWfZr1kuFy8tanrJrW7KFykG34Fqwn8Jr1jvrZIgFsYq34rZrWSy34F
	yFyjvr4qgay7ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jR7K3UUUUU=
X-CM-SenderInfo: poxpx0hj1l0vphwhu3a6rslhhfrp/1tbimgzM9mVLbFZInwAAsv

From: LuMingYin <11570291+yin-luming@user.noreply.gitee.com>

At line 1408 of the file /linux/kernel/trace/trace_probe.c, pointer variables named code and tmp are defined. At line 1437, a new dynamic memory area is allocated using the function kcalloc. When the if statement at line 1467 evaluates to true, the program jumps to the out label at line 1469. Within this function, there are two labels: out and fail. The difference between these two labels is that fail additionally frees the dynamic memory area pointed to by the variable code. Therefore, the program should jump to the fail label instead of the out label. This commit fixes this bug.

Signed-off-by: LuMingYin <11570291+yin-luming@user.noreply.gitee.com>
---
 kernel/trace/trace_probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index dfe3ee6035ec..42bc0f362226 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1466,7 +1466,7 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 		parg->fmt = kmalloc(len, GFP_KERNEL);
 		if (!parg->fmt) {
 			ret = -ENOMEM;
-			goto out;
+			goto fail;
 		}
 		snprintf(parg->fmt, len, "%s[%d]", parg->type->fmttype,
 			 parg->count);
-- 
2.25.1

