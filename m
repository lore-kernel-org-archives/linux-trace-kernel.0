Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D586531B132;
	Thu,  6 Nov 2025 12:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762430507; cv=none; b=pXSxpqSPdYP6mHAYjsNm7diNTidFum7aYtqebW97zxd4OUBZtjYS3aB09U4xrpu14EnYfcI8OlYarj4mH55a/eyZMLkhK/xAjeNN+qMNpkEJtkNn1fKoIfNIQuL87WbP311y477fDM4Fl4/lKWQWVXB8JkrjoiBgcstJyrolsRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762430507; c=relaxed/simple;
	bh=H/Vp3jGJtE3T3rZp+6TX08PYprQhv3Yxrwcst2nUeQI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZNwX5KV5D3z7OBtzxld3nJ+X3le0P5qgZB2fQ2/TusWi0l9XLucjYIoFCwTzgND48/Q50hoHA/9ZBX9UB8sWh0ncNs+n4cs1uf2x/YSEfgPbKWnhthA+SI0GzfhiiNssaRuMuq9S6AA8lnJCW+PiALOgFKx7vN4+7SHAnxsntKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=E+7TssNw; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="E+7TssNw"
Received: from LAPTOP-N070L597.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 28a5e7f1a;
	Thu, 6 Nov 2025 20:01:35 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] tracing: Fix memory leaks in create_field_var()
Date: Thu,  6 Nov 2025 12:01:32 +0000
Message-Id: <20251106120132.3639920-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a590b291d03a1kunm10bc8d337a49e4
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTktJVhpMGR1CSENNGkIaTFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0xVSktLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=E+7TssNwR6IXuCuiKe6G8nGJej7TbG8x9gxapdOpVKf/WWslRFK0ItNXac43H0zYYJVT6fUire15FZlU8INSxfP5OPT5e7edQx///atee3ZgGYuljFsiQqZXn2zATkbfUQBqUVQWEZq4GNB2RsAwBhKxRTy5YgOCS+JJUOl1y6s=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=YVMR0g0cDtjX+fzNvdLc7QoWgdFkMrlNlCpeZgAOK/k=;
	h=date:mime-version:subject:message-id:from;

The function create_field_var() allocates memory for 'val' through
create_hist_field() inside parse_atom(), and for 'var' through
create_var(), which in turn allocates var->type and var->var.name
internally. Simply calling kfree() to release these structures will
result in memory leaks.

Use destroy_hist_field() to properly free 'val', and explicitly release
the memory of var->type and var->var.name before freeing 'var' itself.

Fixes: 02205a6752f22 ("tracing: Add support for 'field variables'")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 kernel/trace/trace_events_hist.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 1d536219b624..6bfaf1210dd2 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3272,14 +3272,16 @@ static struct field_var *create_field_var(struct hist_trigger_data *hist_data,
 	var = create_var(hist_data, file, field_name, val->size, val->type);
 	if (IS_ERR(var)) {
 		hist_err(tr, HIST_ERR_VAR_CREATE_FIND_FAIL, errpos(field_name));
-		kfree(val);
+		destroy_hist_field(val, 0);
 		ret = PTR_ERR(var);
 		goto err;
 	}
 
 	field_var = kzalloc(sizeof(struct field_var), GFP_KERNEL);
 	if (!field_var) {
-		kfree(val);
+		destroy_hist_field(val, 0);
+		kfree_const(var->type);
+		kfree(var->var.name);
 		kfree(var);
 		ret =  -ENOMEM;
 		goto err;
-- 
2.34.1

