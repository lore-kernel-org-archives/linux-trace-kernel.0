Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20BD4ADD81
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 12:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788785079; cv=none; b=T0PD45AIv/3MYkLU9KLHkPKzlkb5jt9nCdkTfr9wsEMcr4BmyNbCfESAW8F6R7UYgbvZ8cAD9E7G7aRoqCIRyP7VY5XBCRKnBfT0UZColn3PFbpZ9BE4EaGIubr6ddnnOmKm4whGMnjPL2UdPQXx6BuW/VUDTkaJ1S7dZz/B5cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788785079; c=relaxed/simple;
	bh=zgY4aTxi1TSbAi0m3aIthn2mGxEvPTI/AYXmeFn2+r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WL0speoOTcixS0JCai14uA6Cuf+NXM1rTQqonvwSUt/VEhOnwivUC1td2tqPKBatjfFiMgoncnV1olUeIFWS0tlojKeab4YnrdwUsMZn20i/fW/ClRDZRwCBk+6n9oP9dRSXvVIZtvmzsVIRAyX5pX54z/Z7wvJ/u57YBjwFJWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ii0FD+3Z; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ii0FD+3Z"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d032846c95so38225375ad.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 07 Sep 2026 05:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788785070; x=1789389870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s/B51kmcLLW7jzdraAVB1DVt4vcDdgF3rCTF3GOFyjc=;
        b=ii0FD+3ZjnRVrt8lMVE0HdMz3hyMJoY8HyvvPDrGXOk6dHu6X+UFRvMF0ZZKCHUscR
         eLJYgBE+iWNyWcrJ5/mZIuE8mIAqzreF2MbUmEUtz/1CYkOnU/PxWdSZ6ddjktPXDGh7
         mvCpZjpDzNhzvQW63Xe4Vmuq1SW/gnDmAfH/F61qnpBbmIKrsnrBC6GZUVtInd5DXIE5
         cxObjeVKlGcldr3TzbNR8pkjDE0CJAFJvF7vL1snKyIdMoTTN4cOHpOIqmhjHOwET0y+
         JE7xZjNIkDlcRhSgKeIZuLk/kj6VzNDi2FTsLfa1ofY9SCghWcfSxNVyzuIy3Amt4ULh
         kHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788785070; x=1789389870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s/B51kmcLLW7jzdraAVB1DVt4vcDdgF3rCTF3GOFyjc=;
        b=c5znOKMyFb59RxigRXS11kDmRjkD4iG6yDi8vuANvjj9TrR1o9SkHRFgaSG56s3vev
         6UxrYgpj1Ddtc5Qc2LRIcFGZIMoaixkeSmW/TKLUdOvr+4rXYL8A1pZOb1o0UYeoNYt8
         hRQYPCkT7ush5J/hXkozmRphgbWf7WlwCFMldjKk0gEzBD91wKxm+TPklPbIhXBtGqCK
         8G2RvePbKCeA5pmm4Xeruz+4padjPhh0uv6ax5ya192qfbefeiViVm9ZhcYJqi6AjXry
         c3Y/7ecAbhIGu6dtyUCKApEOl0HOX6U+0/coAp/iwQRMLX29K2TCSN6FTVfU3ChbQJD+
         7gqQ==
X-Forwarded-Encrypted: i=1; AKwUvBz+7rUvOt5rQhVc8ZLtV2Qvu0qH0s8mBTXp3d5eDzBVnVjL/n4NnlkJb2WjCzuq4hga2HiDAH1K3ZlIgIndtJtE2iw=@vger.kernel.org
X-Gm-Message-State: AFuF++lR23oxweeLWRMciV6ntClmGITNlfmC2+RAXQe1bZ55EW2zbT8N
	gERgwobU7NrKOtUClah7pEMkKPC6efvUZ5BFqYiusECBPVbwTFffd24=
X-Gm-Gg: AYBFou3EeMz/i9TsYtTroqp9LhfrezTMeGs+t68W/cqENy0SQt+yuFaqXAsC8GbNOaH
	BDaqJN9l+NicGdXmxU6cCjh9ZrgQ3ld1D3p1Fzxo2h4UoVgGQWrZw5kplTVW8nIQpv3c0+hSRgX
	Cr8w7FN6uJkLktW80m0p6gtuzMigQX+9PfzoclE3b1LownrIco+GyUzzUH8ic2Kx9zPuuEgqACV
	2FtmceTJaIIRgUlhmExFgxpI153z6yjZiZ2YfpokDN53/Q/BA4bDjTNu5vNNtW6GUFvBFH6/KLy
	zMoDWoprKRNf7xPmWoF92DhmrPv+XFFGwNlrxbpdhDSENLdykkfyUXAUohjnnQKY4c2T+Vf5CuI
	CSijF8EIrXOX43ECNXKUXVmDwf425mdv3fPgYmZIJglW6jjhtw8WCRwJfXwzTVvAPt0llW2vQk2
	SMKsGjXQT9iBF+7tlqlsiyzn0vfYGRWvsaerkbLmeEZhgBWFZi24YJDewtLEOp6UyLiKhglpi2C
	2q8TZRLylmFWzb0
X-Received: by 2002:a17:902:ba98:b0:2d6:fee6:65ae with SMTP id d9443c01a7336-2db1232e1c3mr219541025ad.4.1788785069568;
        Mon, 07 Sep 2026 05:44:29 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:c773:5f09:906c:a72b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db149c3b80sm45350955ad.63.2026.09.07.05.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 05:44:29 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: [PATCH 1/2] tracing: hist: take the reference before publishing the named trigger
Date: Mon,  7 Sep 2026 21:44:19 +0900
Message-ID: <20260907124420.607097-2-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907124420.607097-1-donggeunyoo.kernel@gmail.com>
References: <20260907124420.607097-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

event_hist_trigger_named_init() puts the trigger on the global
named_triggers list and only then takes the reference on the trigger it
shares its histogram with:

	data->ref++;

	save_named_trigger(data->named_data->name, data);

	ret = event_hist_trigger_init(data->named_data);
	if (ret < 0) {
		kfree(data->cmd_ops);
		data->cmd_ops = &trigger_hist_cmd;
	}

	return ret;

event_hist_trigger_init() fails when alloc_hist_pad() cannot allocate, and
nothing takes the trigger back off the list on the way out.
event_hist_trigger_parse() frees it, and the next lookup by name reads the
freed object:

 BUG: KASAN: slab-use-after-free in find_named_trigger+0xac/0xc0
 Read of size 8 at addr ffff888009346860 by task init/1
  find_named_trigger+0xac/0xc0
  hist_register_trigger+0xc1/0xa00
  event_hist_trigger_parse+0x3146/0x6af0
  event_trigger_write+0xce/0x160
 Freed by task 67:
  kfree+0x154/0x420
  trigger_kthread_fn+0xfd/0x160

Do the reference first and publish once it has succeeded, so that nothing
which can fail runs after the trigger becomes findable.

Reported-by: Sashiko AI <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-trace-kernel/20260907092944.3950E1F00A3D@smtp.kernel.org/
Fixes: 7ab0fc61ce73 ("tracing: Move histogram trigger variables from stack to per CPU structure")
Cc: stable@vger.kernel.org
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
 kernel/trace/trace_events_hist.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 963e0d6b61fd..c6c04926bdf0 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6383,17 +6383,18 @@ static int event_hist_trigger_named_init(struct event_trigger_data *data)
 {
 	int ret;
 
-	data->ref++;
-
-	save_named_trigger(data->named_data->name, data);
-
 	ret = event_hist_trigger_init(data->named_data);
 	if (ret < 0) {
 		kfree(data->cmd_ops);
 		data->cmd_ops = &trigger_hist_cmd;
+		return ret;
 	}
 
-	return ret;
+	data->ref++;
+
+	save_named_trigger(data->named_data->name, data);
+
+	return 0;
 }
 
 static void event_hist_trigger_named_free(struct event_trigger_data *data)

base-commit: df2908090cda368b01ff43709f51890076c56157
-- 
2.53.0

