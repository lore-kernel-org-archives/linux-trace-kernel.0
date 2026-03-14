Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9742E391829
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Mar 2026 23:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773531136; cv=pass; b=tZZrYWc60X/G0FQst14wR78Vy9E0dRCRM4IOm8V6HjlFHhJq4nY30Et0OUOQuC4kN+qifSOpsHZUr+mJEn5Ab2pfOiG148S+QJTLZFZKM5bd1UyGWFT2BkMXKP5ny2FqTNoIAmu5P1UynaDyfhiiNZX0XFIMEI9flbw+IC+8GkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773531136; c=relaxed/simple;
	bh=Ca2yOMLol0eXm8Z93sdZF0uzxBHDnoJJ5YjTb0UjCSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W581alf9abp21jzqJQG/ARnM+ta8FuOjatGI8v7PE2/nyFOMgu7SwvEqbZZZNbFCyNATpf0S7Ws3ADs3yfVO844lT4WhCHwWgXNGMRsyONq2N0Xmg5/dik7AtGmOQNJyNmsDLoNX3UUsiyIpmQAAd7Z9VIdM0RGYAh40BHJSkFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=hW1JAhZe; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="hW1JAhZe"
ARC-Seal: i=1; a=rsa-sha256; t=1773531109; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=hMZSA5ESQ7mBhRBd5Yo9LS/ET6xAXilp9UdxWHug0cxKCLzEH8SAbff/Md/Z7RnZwbyHTRzq1+cC8KDAkSPDMUEALFGUBjsDmQLEyRP+3q5s8okPXfCP8nL5fpc8p3+LDWdnLw1iXyykAkJVWHRyF7yGDPpYiIW6zKspnwSUxV4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773531109; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=M861Pari/lV9kRCqOVfEViiGvsDrnuYG9MG+0z+YaXE=; 
	b=LBtjrjmLhJbXErFE9pluF0ehnG2K+B6aR3cJZCPkSII7XTUND6wWZdL/BJ/8j1/ZSLb4fRWfGbSLm33lXcfkziC4fGUqOsy7+xTFaUKx5nKx6fH0zvMdVR9gUiWx/F4Xz2LIO20HAfOgTbmxOZSXUBHooJpjglb+v1wz+INg7qE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773531109;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=M861Pari/lV9kRCqOVfEViiGvsDrnuYG9MG+0z+YaXE=;
	b=hW1JAhZee2gLVD0GNUtJtDkgGNdFN9hyZrJImVMwGam2l/VLF6Ncw6+SO42m60os
	hbZUHP2YR0Eegx0Ar0dxIU4x10l1DckSTRq1blytbSy1kYqSN+Qwa930JXAx8IMWNxk
	6QqQtBZ2jreGDe9rYqwwFtKPi4AN1iXkRO/qFjCI=
Received: by mx.zoho.eu with SMTPS id 1773531108321498.7403371186034;
	Sun, 15 Mar 2026 00:31:48 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 05/23] lib/bootconfig: fix inconsistent if/else bracing
Date: Sat, 14 Mar 2026 23:31:26 +0000
Message-Id: <20260314233144.187273-6-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314233144.187273-1-objecting@objecting.org>
References: <20260314233144.187273-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

When one branch of a conditional uses braces, both branches should
use them per kernel coding style.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index e955d2f7e7ca..45db51bc9cc7 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -473,8 +473,9 @@ static struct xbc_node * __init __xbc_add_sibling(char *data, uint32_t flag, boo
 				sib->next = xbc_node_index(node);
 			}
 		}
-	} else
+	} else {
 		xbc_parse_error("Too many nodes", data);
+	}
 
 	return node;
 }
@@ -992,8 +993,9 @@ int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
 		if (emsg)
 			*emsg = xbc_err_msg;
 		_xbc_exit(true);
-	} else
+	} else {
 		ret = xbc_node_num;
+	}
 
 	return ret;
 }
-- 
2.34.1

