Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793364735;
	b=0uoCLhPUOrI6tpFL63OcyBU0O/tHirlYSLlRXHFW0jOzQWZwmKw0ZHantLmRE2NxVEtu
	 VkYjVf6E6907fdb+rswxFtXHpiTDg/ilSQnkaw9fmXi2LkC1aogRwf4fqrG4c/tciptWK
	 wtIRcLGJKABPVM848/6VB6BDbzKq2huTy8Yne0lPN4iS0lnaFkEfRs+5nggTBXnMrM+Rj
	 zU1qWFt9wmmF14Ufql/fkMaCitQNPhFYsZicYn9NtGAjQUoM+NF+JHrI6RGIpA4fYEkYP
	 hnXQ4K7I3WaHX/iEwcPVVWFwCmgK9+uqGubC6BWgCqyo+29gDMy4DPOrgZhpWLUwu0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364735;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VbBUQQO60+lX0qK2/yrAcJOlkwAqal8iWmnpemgTYFo=;
	b=DUk+q2Jt2plsJIToTtNj4fShACIUbP9VTpkOvqchqxSdyd1kzw4OxrLEnOZH2ABbkCWS
	 pQpAgn2naxI18hEUJ3AzDNKOGn3v1j79Pg73vZZx/PtIWIUDsVs72ScAKOBVBOewfpQa9
	 l1W+nYULZH9uacsp6v3Tg2EYQPNTNrj7KLe5e7yEySXJQt76HLTak3JEU0IDE0NqqxrOd
	 ShkecELgcKJcm31vvDGz7iVw2Secp6LtdXMIo2QXVlTigwqrHLrBw+pdS/8QYmmrWNbOz
	 a36kt7/KS/YkMp8pYTFbWtwBNzNSfovnSXJkRSR+0krV4RmpxPJRHv/wrjUNKdXnnCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="UDKL/EjZ";
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D305606A338
	for <linux-trace-kernel@vger.kernel.org>; Fri, 30 Oct 2026 12:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D305606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UDKL/EjZ
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48e3b22e971so324726f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 30 Oct 2026 05:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793364733; x=1793969533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VbBUQQO60+lX0qK2/yrAcJOlkwAqal8iWmnpemgTYFo=;
        b=UDKL/EjZyYAU9JX5/9jPpxyrvgVm05whzeD8qV9OjjgvxwLwhYTdQxzVZGVJvU6zZL
         nDLrWcrJH8wMzcVcPBRmLZ48VT4HflvDy2VX8gMPojiViBWXFJByvOK/mQB3kz9ZqdS7
         ariLa3ra1XOa5xaw+0hM7z3YW6qEzxel1a6gRuoO4KtfDVP32SQCJrIdZP7zep5h60GP
         1Mhl7q9Qul5GWji37VnVd+hf+HdJRsgJfoy2KbergVp/X2xpLgjCUhxJZ61UvJtdb9ct
         PjVBKtyNOsR+DiVEX4WiUI7+OElXrmFPYHrpgtnia9CqjTeRwo37XFJAG408C6279WkD
         7BHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793364733; x=1793969533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VbBUQQO60+lX0qK2/yrAcJOlkwAqal8iWmnpemgTYFo=;
        b=iAl5CtUXnsQIiO6L72UCtCiWJbEpZLRVVisX1w47bq1jKUBS2zSgwcc1V7sEU0/4pd
         vf1rCfC0I3xk53rFD9vD9/dSfNkGWdDMd5lAVvdSHyXmVF/cdQlxbwS8a1UYqUZpqCLH
         44mS5dNKIAMemc3300gEC/t6jdoYb7KNMqSa5qEOi98AbowJZjQmGJIWoX9uLFut4sai
         4fnoSO0LqlGpN0rXvzGMMsYUHGu/EAjlDNnJaQMl2z6JkNjtpPyjASRI9ofMwfoY125/
         BkY7MnmqKHwAwosO9r7JkG6Pljmiv38x4TJ3PcBDBetMoV3ZQlFvy7iJwv/HyUM71Z34
         Ct3Q==
X-Forwarded-Encrypted: i=1; AKwUvByGoFDJdXmcLCgQIJWCCsuFAGQzliUuFGuMXvcdAZ9DGr9uhPY6PLbt4iUmTfYNAOmoQkdRbNKM8HARx83IyhRBPPY=@vger.kernel.org
X-Gm-Message-State: AFq9FYK9gtO+4scP1WOm3mnGV5gZMY2PhqdZdFyV0ZX6mCLhIDXDnka5
	+qAY8/8ZkShwOLe+TIoea8ot/qiDUGblwzTOepl4vrYfgeMGjS9KYpVl
X-Gm-Gg: AYBFou2HMDOVpB2V+mF1yB/JQ7ZSq6rzBDFJlVuFixcq0VgTctuyWIojJTKEeidGKAr
	Do3aidtwiRxtNOTlKJqKRCdba4DJoA7pYN53GIxye9CFJyFohwd8huOuDSU6aO716K72VRP2VWh
	D0egZYVRpk5Hdj5QSgdd1LdgCNvHg+ylkzss0W+b66vJy6RskTqYkt1HITDZdoSvZoKVzTNnQfQ
	/da0qenyZwllr++GLwVIb7U9ip9U2/cBnw2nMZbuJYMgT9Z7XIcHeRwICurYdRNmgy0vrEB1tpl
	5NKDBg0HUd1WYqaGf5HKmWhERFCH+84Vm/5//3+nx+4Cz5iENhWUpjMUdnvuzGh1q1lcWa5ncFU
	8Hi3ZTCvmehYGTwLygdd0oECKzwLt/AyN0a67P2I+2Rx//1lXhNAocI/9sjqFDa/ZdZi/Oye+fd
	BGrWS8G5gSvfoSFiyxJrch15/N+5s5Af7qldx8fakII5e3mRx8mWHeHsEuMXBUhJiMuZ5ZSfA/L
	aCPsu8SRdHpKGimIKKFyiVmEg86A6W5dyLlsdtZm9/T8UYpnwG3/yzJLrTkh7zjKMv5ZrD16d/K
	67P/dbQnbq6KrSQmTCbqpYbBaDvESsvzh87//uEuPUUyht7gB5io+LumzOlq3rX8Fcho8dvM/SB
	Gl8Gp16zj8HSt17qGHRpQZN+/mitu36oyhmTIBDioJTeUw2m8Lvl35Qk41B4WJLPhA051Vn5Oon
	j2E2U0ESfFQZN9Yo8g/ZAds1PnH3oDkzW9euUijt2Gj3h5brpFTAQ+k0WodZTzu7b9PeUM9BU5/
	pndcM4=
X-Received: by 2002:adf:e901:0:b0:48e:641b:477a with SMTP id ffacd0b85a97d-48e6e4fdbccmr3929352f8f.52.1793364732599;
        Fri, 30 Oct 2026 05:52:12 -0700 (PDT)
Received: from longitude (2a02-8434-fda5-4201-a479-65ed-4521-39bf.rev.sfr.net. [2a02:8434:fda5:4201:a479:65ed:4521:39bf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b723cdsm3170047f8f.12.2026.10.30.05.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 05:52:12 -0700 (PDT)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] tools/bootconfig: Export replayable event trigger counts
Date: Fri, 30 Oct 2026 13:51:49 +0100
Message-ID: <e0659901d096a29364f7dd23352263c37f2ca77f.1793364709.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793364709.git.edumucelli@gmail.com>
References: <cover.1793364709.git.edumucelli@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tracefs displays generic event trigger counts as :unlimited or :count=N.
ftrace2bconf.sh copies these annotations into the exported action, but
the trigger input syntax requires an omitted count or :N. Replaying an
exported traceoff or enable_event action therefore fails.

Remove :unlimited and convert :count=N to :N in the command token before
emitting the action. Keep the filter text unchanged and leave histogram
commands alone, where count can be a variable name.

Fixes: 2b86062a34a8 ("tools/bootconfig: Add a script to generates bootconfig from ftrace")
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
---
I tested traceoff with an unlimited count, traceoff:7 with a filter,
and enable_event with a finite count and filter in a temporary tracefs
instance on my Ubuntu machine, running kernel 7.0.0-38-generic, with
recording disabled.

The original exported count annotations were rejected during replay.
With the fix, the triggers and their filters were restored correctly.
A histogram defining a variable named count also worked unchanged.

 tools/bootconfig/scripts/ftrace2bconf.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/bootconfig/scripts/ftrace2bconf.sh b/tools/bootconfig/scripts/ftrace2bconf.sh
index 8c5889d0420c..82c4fe021fb7 100755
--- a/tools/bootconfig/scripts/ftrace2bconf.sh
+++ b/tools/bootconfig/scripts/ftrace2bconf.sh
@@ -118,6 +118,15 @@ per_event_options() { # event-dir
 	grep -v "^#" $evdir/trigger |
 		sed -e 's/ \[active\]$//' -e 's/ \[paused\]$//' |
 		while IFS= read -r action; do
+		action_cmd=${action%% *}
+		action_rest=${action#"$action_cmd"}
+		case "$action_cmd" in
+		hist:*) ;;
+		*:unlimited)
+			action="${action_cmd%:unlimited}$action_rest";;
+		*:count=*)
+			action="${action_cmd%:count=*}:${action_cmd##*:count=}$action_rest";;
+		esac
 		emit_kv $PREFIX.event.$group.$event.actions += "'$action'"
 	done
 
-- 
2.53.0

