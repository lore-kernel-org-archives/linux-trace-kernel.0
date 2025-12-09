Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F00026ED3E
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Dec 2025 22:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765320033; cv=none; b=c+sfp5f+Yz64++Ega6JMrwzL+TO46BBWQ/k/mipJd3Tx4fucEiZ9VGUQaS1on42briDqy/GaOqHr3CBrxt0MgcV3XUq6Aj2HVi8Z5B21eUF54wbVqCOShBOK/Ww/nyRvhiOBBoJORMuDo7d8fIBtMGjsQtR66LPdvhMTkvuLN0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765320033; c=relaxed/simple;
	bh=tCh98JTKTb7XJKJ0j/3MlluR1scTujkw4X+uEScIUTo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Fh5q2pLLV2VOKF9yzPhiCVK5c88Zbexeg0Kqba79DL6L906V5Y1I36fTqgU1+Nb91Ks8U19bPPfoD5WztfVZhfHFalpNNxcYjdP+PlprIG2nCB5ww8T2lZV10c2tlh/WttV7A++5RD+nIYPHPB/FgSOa9YRsU1WYsOA68V7kRjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1B49VFT9; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1B49VFT9"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297dfae179bso125776895ad.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Dec 2025 14:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765320032; x=1765924832; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r7O48LXkjdqgnjge+x6j1USdfdM5LKXe6u1Y0sEV654=;
        b=1B49VFT9YA0AGxHZnccpZnNzt9Ynt/QYCqxYivRftjsVygbyd0LvKMA50aFfmH+aip
         pAtJUADx9O2JCTJu7iVBM9Mj80V/wDKBfDXoILapfo2l09GG+8uyb+svfhwcxyxrk+ZL
         FSe2ZWk7I5XaJxOAymVv7wD0L+W7rKZMlsBbKYodotlNdIwKvNgY910TKwtjc4rkhcll
         jY/8e9KU6Ugwq2NggMsCAMixFyp+9EjgVQNkUz5OhlCn22z12fsk+AZWsjyhgUOJphQn
         evUHriOn4ln9V3u6PlnnGlJDPlEqePtW/H8moF2Jx8b8COiB6vxaJxUfdIWdNltLVW9S
         yN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765320032; x=1765924832;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r7O48LXkjdqgnjge+x6j1USdfdM5LKXe6u1Y0sEV654=;
        b=YMfLdK+jyZFec0YZwLAFV2I26HWU9Q/9TgvbT2W4oPKF5E1z423MAZg8yPHekQB6NV
         7DZ4sexb2xrwf8jZa1yqIgW+KvUZM9QfPAMf0Z/uijbq9k1ZQohCcZHyM9Ibi9nn04SO
         ihlZcjX8b6ese14jMeVU6PzIaJt+C/HmeaY22Nj1EPp+DQiTwWHf/xTPGlTCG+/HjXRl
         lN3EzzJyzNHESFiAHMB9LY1vQy3d0T2IfS+FKLU+dEufxTQosozAwALzx74dhOruHnM/
         n1GsQZIMMjyqgIQJLbxjR7+JP4pWiUOyU0BakDyB9qKaajHil5aCgObg1yV/2c0Qxnhf
         J3WA==
X-Forwarded-Encrypted: i=1; AJvYcCU1/Ge2eaS6z3rYI+SXAlRP57IJxjN02/V9XxKg8mG2gXA789T6LSU7CwoVW56cwKnQeK5wG9yS/4ERWZEvCRKt42k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw5kRNgqHKaKw/FmVYaJD8xFvB32fFmocwI3QhpQMZ2iim8YQ4
	FanltoVIrEG7TkiJMUqD8v5bEd2vR72yXFJd8CfDIynzHA0xVNB5Ci9DddJ2vjFg85lI5FSCD3P
	dm37eDWqv3A==
X-Google-Smtp-Source: AGHT+IFj4rqsfnPj3U/wPD6U+SDvCHeJsw7sYeBk6s+QvKgbGyD2On2jOkfICHVlusYJjqYFg+wML/xfAOAV
X-Received: from dlbbk22.prod.google.com ([2002:a05:7022:4296:b0:11b:9777:3bd6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b9c:b0:119:e569:fb9b
 with SMTP id a92af1059eb24-11f29655a78mr189095c88.10.1765320031766; Tue, 09
 Dec 2025 14:40:31 -0800 (PST)
Date: Tue,  9 Dec 2025 14:40:24 -0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251209224024.2322124-1-irogers@google.com>
Subject: [PATCH v1] tracing: Avoid possible signed 64-bit truncation
From: Ian Rogers <irogers@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

64-bit truncation to 32-bit can result in the sign of the truncated
value changing. The cmp_mod_entry is used in bsearch and so the
truncation could result in an invalid search order. This would only
happen were the addresses more than 2GB apart and so unlikely, but
let's fix the potentially broken compare anyway.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 kernel/trace/trace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d1e527cf2aae..e6a80cbe9326 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6057,8 +6057,10 @@ static int cmp_mod_entry(const void *key, const void *pivot)
 
 	if (addr >= ent[0].mod_addr && addr < ent[1].mod_addr)
 		return 0;
+	else if (addr > ent->mod_addr)
+		return 1;
 	else
-		return addr - ent->mod_addr;
+		return -1;
 }
 
 /**
-- 
2.52.0.223.gf5cc29aaa4-goog

