Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2277F43ABC;
	Sun, 15 Mar 2026 12:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773577472; cv=pass; b=IC+V+dQnFrhOfCmKZmgpGN7kLP/qWF6C8y5TUHz67ujhEDQjdFlJzOzv8wwbe4WnKNMurHqsFtDHOoQRPd16olc5OAggeKG6Oygzub++EmBPZpOKt0biqgMxVek371TT3LQQHskgkeuVASkCKl+NekCQgL/yXEY/vPLOJFTwa7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773577472; c=relaxed/simple;
	bh=ZuUlVeCERGWi0kiPXUflzzixT8Dr5l8GMnBPX34kkGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VBrCnbhZiep4RcXQx6DPtznSlVIcMPMA9GVleU6hjCN3x2ptNBi3t1hkfxar7204KnCp5DHtePBuvgB7oEh0HpqoxMmyT7FXqOIsWfcRr22DXx3x8oKG1XvS+gdKyzmJfTzNmpkBNuJ380mgzmbXum/pAKzvhydMDXMZEGDeapI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=kOFp3zYj; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="kOFp3zYj"
ARC-Seal: i=1; a=rsa-sha256; t=1773577224; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=cxZf4aGVYpItIiuLs0S8ulqrCsIVHHObuLpnfyy6i2QtCsvWtrHFeBDVRQp9gtXNMr5Na4al00VwbIRSwJfzcdCly7QNfIeY9Q8tEbNhclUOSaBzTe6uIWV35H91nw/KUiUgpnpVT8QHP88pikR2SY6P6NPuXJggZzlclPl5PJU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773577224; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jQa+d6xwRxy5WvG4jIfj7hMRpG3HkL2h6UH+aTlgbd4=; 
	b=USU1j8kHadaaK0+Y5irdXLsxKRCxBEtPheKHs7CDjuODrLp3WhohnM+S74twRYxHBDuaK3p1HzH7XyXrQuVCZHLF+Dce9vUvXmE5I80cvECqHq399cVG7uZGBlMCUGb7W1wG0bsohVhXekBU9WvZ29umIJ0qUVoPpdLeHtSu9mU=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773577224;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=jQa+d6xwRxy5WvG4jIfj7hMRpG3HkL2h6UH+aTlgbd4=;
	b=kOFp3zYjYZkGnqF9jTg9A1uOJ71wuvUeKvSLfs2TDZJPLRqlLunV1/2/JuCLgL4F
	YUNrcTtcaw0DqkdVtQsebHTFkEKaNXW4fx/w4KeCCoXJk10X1dkkKD56wiPCg4xrrlR
	6sXFHW5u/s17KIgDaZMHV4nWMsQSR4q8G3xJg60M=
Received: by mx.zoho.eu with SMTPS id 17735772225191.663051885701634;
	Sun, 15 Mar 2026 13:20:22 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v6 09/17] lib/bootconfig: validate child node index in xbc_verify_tree()
Date: Sun, 15 Mar 2026 12:20:07 +0000
Message-Id: <20260315122015.55965-10-objecting@objecting.org>
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

xbc_verify_tree() validates that each node's next index is within
bounds, but does not check the child index.  Add the same bounds
check for the child field.

Without this check, a corrupt bootconfig that passes next-index
validation could still trigger an out-of-bounds memory access via an
invalid child index when xbc_node_get_child() is called during tree
traversal at boot time.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 0823491221f4..038f56689a48 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -823,6 +823,10 @@ static int __init xbc_verify_tree(void)
 			return xbc_parse_error("No closing brace",
 				xbc_node_get_data(xbc_nodes + i));
 		}
+		if (xbc_nodes[i].child >= xbc_node_num) {
+			return xbc_parse_error("Broken child node",
+				xbc_node_get_data(xbc_nodes + i));
+		}
 	}
 
 	/* Key tree limitation check */
-- 
2.34.1

