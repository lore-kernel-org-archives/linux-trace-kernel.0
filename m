Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F83738DC74
	for <linux-trace-kernel@vger.kernel.org>; Sun,  6 Sep 2026 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788698436; cv=none; b=eBL7ZbP3T5SwuQoPhVF/5PqBcNRynSDmOh04Ha4Rmm+fu5dGQqJ6JGfXREW8LA53nraKRqAReAbYrGn+iBfLyT4steMjczNBQFaueL3UGjdzN9GaPzGnqJkij49T5ViUoQbrQYIMl0U2A5Qwp74CVYpQHlVa0eIzFxIAk/ll7Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788698436; c=relaxed/simple;
	bh=48zN5gDkt335ZWJwEnQrm9lNHGpPcYw1ZDJEI3WvGoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=foGr/eYDl37bFE18jOJ3EtKwD50xCZxDmSQT9gfmncSnAGOV7Vj606bwTfZViMuyCUUXVDDKLDKpLFen5HMGX63IdM8o9BgdpEh3pGb/Ktax0sCu5HG3GzysPbB01TIdF81lUiYvGFns4YGqr1R7TonIB9Z8C/oCQ+/IQPFfgvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kj/svzLU; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kj/svzLU"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3966791a6eeso3124347a91.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 06 Sep 2026 05:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788698432; x=1789303232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Tls/LC4+9ZyOkyuToAojJmb/W5OKZbgatlDq3B6sz4=;
        b=Kj/svzLUDlCyWGPtxJo6XLN4lSqK2cMRbgVfvczntJCM1cp+ADoEygw3Qa4cNo20Mx
         P0zRiOOCscTTJAtOGT4f1G7FqYNhZnPTPgTs5JQxgRrMIuJsoIEFbbciQrbcYbi5EVSy
         nWyNCZe5L0/zRnuZc2LSTRAsAqyI7vEtSsCGsPJgZG90YscagiZ3+ESc0ruHGC1RHyFH
         vSyU8/GA4Fr0Z5ZPvVEZc5KxOWlL44NBMs/in2WzChm+05c9bwKLc8yt5l8IQdBtWIg+
         43nUwAv1O2ELM0H/NopyGCZff+pd/AOPCsakdVvvpoMiSghZuQ1KsdwgNH3kE/1ttwap
         djYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788698432; x=1789303232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Tls/LC4+9ZyOkyuToAojJmb/W5OKZbgatlDq3B6sz4=;
        b=XwJAfWKan2kLwp7GiNaFitsf7Nf5L0bh89hPtdeI9nXXxA8S8ONuPKJYA+xNLeff8u
         WeuiAk8i6COua6V3958dkAGDe0RTic38SbucD0jjmdY7JhPbDCfdHWb4x0RlNZ4QGj9f
         Z75rM6DW1exr6fKvCph7Yolu1jo2dS3obCnyhaBECxqI7qAWtBuh4Y8gAxocc3Z9mczQ
         Ms6joWEJLeqFbGBgBnoOExUXXpl5UmDIK8xzRLeMWBxpfFC29as4Lw93IBrJI12lOhji
         Rz+MUYbzgYieqagnn5gRq5jGwLDtEuDsTSU+bevIshN7PgkX4X/mgAl4hXIFTixtMbky
         qXjg==
X-Gm-Message-State: AFuF++lggF5+wP4vxfqpVEhFjf2f3SS11270ZrQg2b3eQcpy/3+SOzeK
	WIB9rbHRsDX6ylSaV2ljoOsZOBUzSpp9PQKKtCrLPm7RdamlAdzm3Fg=
X-Gm-Gg: AYBFou1WmW7KGlLQXto4RMbEnVHUxvQ5kPghEIWHSOfBKxdfFk01uSApff4ZwA8mrOt
	oXxpitcbP4qHHprdOL20DoDge/8Myl5CSXL7Xz6shbDgmlm2htITWHpqsVdPR6pZVhIKb00wYzg
	l8O2M4b9uGRDTTotUOhmYbwMGXYAm6vqXWxrouHBjh9jDoWe3eNf5OLoAuP1zbVKZjgXIFFq2Hx
	+CZoSlN9OK8lbxsuhtDiwCxm1ErSrljFLdl3UGRltYmrPTVJPTuZom7KajBzhS5IGSBN7cuCJAS
	Ed9IMRuQu53OBK7K17E1WGeX7Tq5HPCQ87lvLXZCNk/Vqm+FGsJn9dBEyMpBGW8F7H9YewYtN9K
	zv0iAIUOjAfCOreWWxNLWAAQhUGKYkvgKd/UqBOjyLBQzwaO58t8uI/NZE4HnEd1XRWqkA7XfcM
	hEdHnvrki18qYBCsdJXDbTOH4D+hPZZ8+KeA74W1a6uN2EFBla/WSbZdhS+m6XED/8SrY2tgPMX
	WbxH3PCJWzkq7X+
X-Received: by 2002:a17:90a:da8f:b0:398:b71e:60c1 with SMTP id 98e67ed59e1d1-39b26208e7amr24843114a91.12.1788698431962;
        Sun, 06 Sep 2026 05:40:31 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:2b14:fe4a:ab17:f236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08bcc090sm21083005a91.4.2026.09.06.05.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 05:40:30 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: [PATCH] tracing: hist: free var refs regardless of how often they are referenced
Date: Sun,  6 Sep 2026 21:40:25 +0900
Message-ID: <20260906124025.3550596-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using the same variable three or more times in one hist trigger leaks the
variable reference and its strings when the trigger is removed.

commit 656fe2ba85e8 ("tracing: Use hist trigger's var_ref array to destroy
var_refs") made a trigger's var_refs[] array the only owner of a var ref:
destroy_hist_field() returns early for HIST_FIELD_FL_VAR_REF, so the field
expressions never destroy one. One entry, freed once, no count needed.

commit 8bcebc77e85f ("tracing: Fix histogram code when expression has same
var as value") then made repeated references share one object and added a
count of them. Only the increment side exists, since those expressions
still return early and never drop a reference, so __destroy_hist_field()
sees how many references were created rather than how many are left. It
frees when the decremented count is 0 or 1, so two references work and
three or more leak.

Sharing kept one array entry per object, and create_var_ref() searches and
appends within a single trigger, so nothing outside it holds the object.
Removing a trigger whose variables are still referenced is already refused
by check_var_refs() with -EBUSY. Drop the count and free unconditionally.

Fixes: 8bcebc77e85f ("tracing: Fix histogram code when expression has same var as value")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
Reproduced under QEMU (x86_64) with CONFIG_DEBUG_KMEMLEAK. Two triggers
differing only in a third reference to the same variable, each installed
and removed 200 times:

  hist:keys=next_pid:delta=common_timestamp-$start,start2=$start:
      onmatch(sched.sched_waking).trace(first,$start2,common_timestamp,next_pid,$delta)

  ... plus delta2=common_timestamp-$start

  two references    0 unreferenced objects,   0 bytes
  three references  620 / 666 objects, 62000 / 66600 bytes over two runs

With this patch both are 0. kmemleak points at the var ref itself and at
the strings init_var_ref() attaches to it:

  unreferenced object (size 192):
    create_hist_field+0x39/0x390
    create_var_ref+0x96/0x100
    parse_atom+0x4ad/0x910
  unreferenced object (size 8):
    hex dump: 73 74 61 72 74 00 00 00   start...
    kstrdup+0x37/0x70
    init_var_ref+0x88/0x110

tools/testing/selftests/ftrace test.d/trigger: 45 tests, results identical
before and after, including the ones covering variable references --
field variable support, fully-qualified variable reference support,
inter-event combined, onmatch, onmax, onmatch-onmax and trace action all
pass. Three tests fail identically with and without the patch (onchange
action, and trace action with a dynamic string param); I did not chase
those down.

checkpatch --strict is clean and an x86_64 W=1 build of the file adds no
warnings.

 kernel/trace/trace_events_hist.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 963e0d6b61fd..f90680b33a37 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -169,7 +169,6 @@ struct hist_field {
 	struct hist_field		*operands[HIST_FIELD_OPERANDS_MAX];
 	struct hist_trigger_data	*hist_data;
 	enum hist_field_fn		fn_num;
-	unsigned int			ref;
 	unsigned int			size;
 	unsigned int			offset;
 	unsigned int                    is_signed;
@@ -1913,16 +1912,8 @@ static int contains_operator(char *str, char **sep)
 	return field_op;
 }
 
-static void get_hist_field(struct hist_field *hist_field)
-{
-	hist_field->ref++;
-}
-
 static void __destroy_hist_field(struct hist_field *hist_field)
 {
-	if (--hist_field->ref > 1)
-		return;
-
 	kfree(hist_field->var.name);
 	kfree(hist_field->name);
 
@@ -1969,8 +1960,6 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 	if (!hist_field)
 		return NULL;
 
-	hist_field->ref = 1;
-
 	hist_field->hist_data = hist_data;
 
 	if (flags & HIST_FIELD_FL_EXPR || flags & HIST_FIELD_FL_ALIAS)
@@ -2223,10 +2212,8 @@ static struct hist_field *create_var_ref(struct hist_trigger_data *hist_data,
 	for (i = 0; i < hist_data->n_var_refs; i++) {
 		ref_field = hist_data->var_refs[i];
 		if (ref_field->var.idx == var_field->var.idx &&
-		    ref_field->var.hist_data == var_field->hist_data) {
-			get_hist_field(ref_field);
+		    ref_field->var.hist_data == var_field->hist_data)
 			return ref_field;
-		}
 	}
 	/* Sanity check to avoid out-of-bound write on 'hist_data->var_refs' */
 	if (hist_data->n_var_refs >= TRACING_MAP_VARS_MAX)
@@ -3276,7 +3263,6 @@ static struct hist_field *create_var(struct hist_trigger_data *hist_data,
 		goto out;
 	}
 
-	var->ref = 1;
 	var->flags = HIST_FIELD_FL_VAR;
 	var->var.idx = idx;
 	var->var.hist_data = var->hist_data = hist_data;

base-commit: 1fc5a74b108fc90951890ec513ac81869f5eaff1
-- 
2.53.0

