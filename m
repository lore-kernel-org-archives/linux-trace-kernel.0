Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB7F282FA;
	Sun, 14 Jul 2024 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720965043; cv=none; b=iZK8Y4NSlVhHD0iDzbIF4ukYeVxElanu/mgOUtBAH8ihSh4xgcMadM5kEAiDHQO8fWD/fU/xrTKUUyjH/dKF2f4EwDsl45jxAheeZ1zin9sq3gcoESwUOezubRQjQiWF9ixH442aKJnNyCXREQjcUBGDEQzJ3LIEqK7SNTybOzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720965043; c=relaxed/simple;
	bh=xoOmcy7KnFqs1Zf4FwEtkV1JjTuxBPnOj89BZBoxO2Y=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Bw9MFGn4f3muL6SWabITUyBfgvwUbixsFLbl0oN3+XeTA1pIgbQD4Eqyvh8x8UW8nHMG3iLtwygpRFnERgs2RTewSHgZoG33DSQ34GyGMpxA/rCY49d0n4ccS9bx6sBG5D05+lA4nU+6aKVrs11qia7pTv3MV8Gnb/zCDtLY4ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=DbyHAr+v; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="DbyHAr+v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720965029; x=1721569829; i=markus.elfring@web.de;
	bh=rpnzC2l4qRrm2pED4+3khrp6p5nM0fa/gQaNMi04FWI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DbyHAr+vk3tPLXbA2q0XbgFDXW/wXHj7bylHVBX5daYU6SOMi8+LlctqrWItcbHo
	 2w6XMD6md62FlET70avypvRW++QNCxVrYYW0Z9PyfA9xBY3wKyZpBFby5NViZSo+M
	 WRV0mpUFKl4gt208rvYbuKwXeFklLjpYzmcXsowhyZqKYL3wgIto7vXTS1Z5TdBkA
	 lKiN/vWxJo38XuAJSB4ZC7LPadYf1NTpX4VEca4m0MKdj53MRuRJXZ7k7IuSQPMha
	 jaC5kd9azhUCqcUQfXflcw8Jt1o1bw4T2X1JjeuQTtXBDL3g330A9ZaIY19VbBT5Z
	 uFLJRwfThpldrcTYgA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgRQJ-1rriSw0P55-00gRxL; Sun, 14
 Jul 2024 15:50:29 +0200
Message-ID: <0adc5c58-79db-4b58-8a43-bffbfe0cd2af@web.de>
Date: Sun, 14 Jul 2024 15:50:26 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-trace-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Daniel Bristot de Oliveira <bristot@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Steven Rostedt <rostedt@goodmis.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] tracing: Replace 21 seq_puts() calls by seq_putc() calls
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bpgkYJTiK77zhIGwJZ19TY+mXMRI/+Nfp+x84duOjmY7+HmNMQk
 uS8KeuIUg7BrQ1IYYHYCZp1wxHgzsTDBkgEQMF2iI6hnrwUsrNbtwHBXNek2DPn8gHGq4HO
 xSjNU4Kti81eEE5cHutcXyoT/gOA40t37BrtPLo9xAkWN0BW7J8S4soiw9orEzR6YDaESQ4
 PtQoqJwjXDWFtOiSbSBZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9A8aYhqFFCM=;s3S7PFnGJx48DjK0UbxLN3lQG1y
 IdTUQDwYkUJTiirRuE6mw2AMdGqsRmvM61IcqfRJvkZksBaZmRqDh4+1+YOAjRs98yxmO9l3s
 Voia8xDdttJpYgjZzO/if7JPj6lgfOR/1SucguOJYFnvG4xtW+CzFO6G/oaaXxWUeepHCXARU
 vq/kxtpQ7RgORyv48KXcqavkL6Usd/0DjwA6Hz29tTftNhkSYyVvvjVIAzknlqLOw3/5ppPlm
 LlFPbkCArdXOFoa7OdIOEjUuq6iU1E8Ca8giN2OlVLZfDQiWk2HuVyVF1d1rFsc0bGTDNqDht
 Tzl3JV/pdBrzVLyQDr/wYx5DXtRpiu+7oKfWWsBSimi0DhTSPItK+SeOFjampqYWIrsrrlCsF
 T41GBHsLpqFqOzgoplynOTihqz3314jzK4XQryFimbraTRjlTxnA3c+bX9PZYMlKXMH7lDFKd
 XWq584tA/s/jQgnXWSuB1l80JCo9bJZwdODdbeR2jTHGiIQNAo/STS+uVdqEkm+j25d4RcofL
 8nircvWGyU3sSKWwiA0/3PApUccjIPgiVGG9b6ak2ZfeOaiITDXtxHLLHIo6FdRg+/Lga0UyM
 70X/jF46u8lkznZMMIzovdK/RwPdk7g0cHxKNK9m6vMv7wpysRqKHUqWeFj+27Ih6wrrN7RhG
 8msX8DnR9fIdB3pXMiZMiJlKb20GGAx2XpipCNgZBrziY1BonUgFoKrVsfR1kfuMiFDmpBOZH
 nQMQeucp56xIhUwcfQr+G+OmV3xaJCd4xqx2yD83GuEwDWxy7WPSLoA1U/BZrWswZEzJ7xlGk
 tTfFkpL3SI4PeGSiOAnChK9w==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 14 Jul 2024 15:40:34 +0200

Single characters should be put into a sequence.
Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/trace/trace_events_hist.c | 26 +++++++++++++-------------
 kernel/trace/trace_events_user.c |  8 ++++----
 kernel/trace/trace_hwlat.c       |  4 ++--
 kernel/trace/trace_osnoise.c     |  4 ++--
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_=
hist.c
index 6ece1308d36a..5992278cbfb5 100644
=2D-- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -4898,14 +4898,14 @@ static void print_action_spec(struct seq_file *m,
 		for (i =3D 0; i < hist_data->n_save_vars; i++) {
 			seq_printf(m, "%s", hist_data->save_vars[i]->var->var.name);
 			if (i < hist_data->n_save_vars - 1)
-				seq_puts(m, ",");
+				seq_putc(m, ',');
 		}
 	} else if (data->action =3D=3D ACTION_TRACE) {
 		if (data->use_trace_keyword)
 			seq_printf(m, "%s", data->synth_event_name);
 		for (i =3D 0; i < data->n_params; i++) {
 			if (i || data->use_trace_keyword)
-				seq_puts(m, ",");
+				seq_putc(m, ',');
 			seq_printf(m, "%s", data->params[i]);
 		}
 	}
@@ -4924,7 +4924,7 @@ static void print_track_data_spec(struct seq_file *m=
,

 	print_action_spec(m, hist_data, data);

-	seq_puts(m, ")");
+	seq_putc(m, ')');
 }

 static void print_onmatch_spec(struct seq_file *m,
@@ -4938,7 +4938,7 @@ static void print_onmatch_spec(struct seq_file *m,

 	print_action_spec(m, hist_data, data);

-	seq_puts(m, ")");
+	seq_putc(m, ')');
 }

 static bool actions_match(struct hist_trigger_data *hist_data,
@@ -5413,9 +5413,9 @@ static void hist_trigger_print_key(struct seq_file *=
m,
 	}

 	if (!multiline)
-		seq_puts(m, " ");
+		seq_putc(m, ' ');

-	seq_puts(m, "}");
+	seq_putc(m, '}');
 }

 /* Get the 100 times of the percentage of @val in @total */
@@ -5511,13 +5511,13 @@ static void hist_trigger_entry_print(struct seq_fi=
le *m,
 		if (flags & HIST_FIELD_FL_VAR || flags & HIST_FIELD_FL_EXPR)
 			continue;

-		seq_puts(m, " ");
+		seq_putc(m, ' ');
 		hist_trigger_print_val(m, i, field_name, flags, stats, elt);
 	}

 	print_actions(m, hist_data, elt);

-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 }

 static int print_entries(struct seq_file *m,
@@ -5971,7 +5971,7 @@ static int event_hist_trigger_print(struct seq_file =
*m,
 		field =3D hist_data->fields[i];

 		if (i > hist_data->n_vals)
-			seq_puts(m, ",");
+			seq_putc(m, ',');

 		if (field->flags & HIST_FIELD_FL_STACKTRACE) {
 			if (field->field)
@@ -5997,7 +5997,7 @@ static int event_hist_trigger_print(struct seq_file =
*m,
 			seq_puts(m, "hitcount");
 		} else {
 			if (show_val)
-				seq_puts(m, ",");
+				seq_putc(m, ',');
 			hist_field_print(m, field);
 		}
 		show_val =3D true;
@@ -6006,14 +6006,14 @@ static int event_hist_trigger_print(struct seq_fil=
e *m,
 	if (have_var) {
 		unsigned int n =3D 0;

-		seq_puts(m, ":");
+		seq_putc(m, ':');

 		for_each_hist_val_field(i, hist_data) {
 			field =3D hist_data->fields[i];

 			if (field->flags & HIST_FIELD_FL_VAR) {
 				if (n++)
-					seq_puts(m, ",");
+					seq_putc(m, ',');
 				hist_field_print(m, field);
 			}
 		}
@@ -6035,7 +6035,7 @@ static int event_hist_trigger_print(struct seq_file =
*m,
 			return -EINVAL;

 		if (i > 0)
-			seq_puts(m, ",");
+			seq_putc(m, ',');

 		if (idx =3D=3D HITCOUNT_IDX)
 			seq_puts(m, "hitcount");
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_=
user.c
index 3a2b46847c8b..0a24bd3e57ef 100644
=2D-- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1823,7 +1823,7 @@ static int user_event_show(struct seq_file *m, struc=
t dyn_event *ev)

 	list_for_each_entry_reverse(field, head, link) {
 		if (depth =3D=3D 0)
-			seq_puts(m, " ");
+			seq_putc(m, ' ');
 		else
 			seq_puts(m, "; ");

@@ -1835,7 +1835,7 @@ static int user_event_show(struct seq_file *m, struc=
t dyn_event *ev)
 		depth++;
 	}

-	seq_puts(m, "\n");
+	seq_putc(m, '\n');

 	return 0;
 }
@@ -2807,13 +2807,13 @@ static int user_seq_show(struct seq_file *m, void =
*p)
 			busy++;
 		}

-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 		active++;
 	}

 	mutex_unlock(&group->reg_mutex);

-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 	seq_printf(m, "Active: %d\n", active);
 	seq_printf(m, "Busy: %d\n", busy);

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index b791524a6536..874a81cf9bb7 100644
=2D-- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -636,14 +636,14 @@ static int s_mode_show(struct seq_file *s, void *v)
 		seq_printf(s, "%s", thread_mode_str[mode]);

 	if (mode < MODE_MAX - 1) /* if mode is any but last */
-		seq_puts(s, " ");
+		seq_putc(s, ' ');

 	return 0;
 }

 static void s_mode_stop(struct seq_file *s, void *v)
 {
-	seq_puts(s, "\n");
+	seq_putc(s, '\n');
 	mutex_unlock(&hwlat_data.lock);
 }

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index a8e28f9b9271..886fedc85d79 100644
=2D-- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2173,14 +2173,14 @@ static int s_options_show(struct seq_file *s, void=
 *v)

 out:
 	if (option !=3D OSN_MAX)
-		seq_puts(s, " ");
+		seq_putc(s, ' ');

 	return 0;
 }

 static void s_options_stop(struct seq_file *s, void *v)
 {
-	seq_puts(s, "\n");
+	seq_putc(s, '\n');
 	mutex_unlock(&interface_lock);
 }

=2D-
2.45.2

