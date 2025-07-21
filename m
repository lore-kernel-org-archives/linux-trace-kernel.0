Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5747B2DCBEB
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753108177; cv=none; b=X9xpkk57vwgGoGBRT1IkihmzHVTjxGXGojdIx7O23WE3Dv6h9xTVUiGrfi/Steww/PwweNnLgZYBPyJ1kNJTQQBX8HDMZWj4pjCc8HqvptPcmKhQ39xML23uYcXfWPPkMvVwWxlPIxkOiir5TY2yd/LamckwUOdL6KMS6CS3ac8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753108177; c=relaxed/simple;
	bh=HavMS65qmeu08gDiqywa9LUb3AOthVw/FnGAmNmwi04=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcnuWr0WWKvjeJfKuliqCg0HQ1KUZG3Mk7taK/oHV3iWpAFU166HnxIs+3Gh77jOednFv39OQcE8uKAzqt2zWnoVNm+1peWwARjuUqB3mtAOkFKemXZmGrf/kvBN6rOWE1v244ehaJ3xH9scrUu/igCvRz8SqWkEm03kwXf/qV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HWwXgZOe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWwXgZOe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753108174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HavMS65qmeu08gDiqywa9LUb3AOthVw/FnGAmNmwi04=;
	b=HWwXgZOepbSRQcj1kygjI3qk1ynU4x3lJ5VMJvqTiYeMwwoFRuSxMo6Va+2FPbfnww6F6m
	PpggnR90XyWv+iLGabkz59CANev0LhIqhTz6UC42xrQ9oOiIRoPkRh9a3bBHJe3hKhKVDC
	XITZiD1Z8I5Lt3NHk6NjXkc+QHi6ERU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-74WLaAYoNPihRdfhMbAIxg-1; Mon, 21 Jul 2025 10:29:33 -0400
X-MC-Unique: 74WLaAYoNPihRdfhMbAIxg-1
X-Mimecast-MFC-AGG-ID: 74WLaAYoNPihRdfhMbAIxg_1753108172
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b5f97cb8fbso1885947f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Jul 2025 07:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753108172; x=1753712972;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eg11g8j/Kap7sn28tr8YjA+6x3TTLx5fyEZpMapHf3E=;
        b=LL2mszvPF+i49njQ8ZRady91R0sQDVdTrzLEXLS38SklCbd5d2zFwR98Okm8Y4LIXl
         GUgdfhmAVc3VnCnF26NRF6+96ra/hD00wQyzE1lFZOlulwdxNu6Q2NQhEEoNvAscPy4t
         F3XChOH1JyYLIsXbVM7Ye1vGQZ/fHJ7vH3vJ6L4UMrg2jSHb5/uXiGI0nKwB3CtTA7Ru
         f7BIO13w74oz2hzU+GOIsmdm/VFMvI7OJGCmRZztYgjJeVmQ2pzgCLzuE96xs13XfORN
         AGJL7QctXrApqsqz8lp7zmyiNBleZVIWABpAh8uC6pf2H5dWdRdC0Ik3SV7+TaAC5Jky
         ezpA==
X-Forwarded-Encrypted: i=1; AJvYcCWNQWgCfqgVEr0NxWqECkmX5FFqpHrwMkbjllV+R8Grc5O/ojMQah6fncAKyUMvnEAFK00NqitVUoEKeyZmjpKcViI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXFXuVUhAKj1UTt1CZHvgtKDb6EVdW8uZZ64Gz5OIVZj9XZLAD
	/ZIHPcNGoAD676D+yh0cQD+ttbnZ3ERyqcJRz8rFy6TtNJkT3x8boCcH5y2RVV1jSP2xSEW5w8n
	yacX3mbaFzXZZSaJnqNzQm5PiIf/szshIxQbmSQDGV3aBeZ0W41Q6NuQpRgdWlRY0RS/7zOUcoA
	==
X-Gm-Gg: ASbGncsTkPt3a0wO4r5m3dY+0AX3PazEuH8eWAF+8rtOyTCtVEjB1bDZ2cEnnsu34+5
	h66EQVpVudlGEN9VaosfhV/3fyD1+pWBgCII1oi8+/uohto73d4gxkHT80+9/LZWdxroo5xZx0M
	0aKUfUwmxL1gg+BzAGwvrMPZJfHO6Dk/BGhD0GJXJZ6z6abdE9m3+pdWYL1aLhhWsDpY9TKEec6
	HTwROdPaBWpGTGomS0KGz9F/6XCY2EVifGPA6QVsfqR2L53mvXTmISPHl9QzNibuqoSWB1mDq8K
	R+VDZ8imllwMuqIVy9TUbWZsuxyth8s8r2nbVOmE1hRyq1B0fufH0AZXa1bv+1n1mQ==
X-Received: by 2002:a5d:5c13:0:b0:3b5:dc2e:3cd6 with SMTP id ffacd0b85a97d-3b60e4d0250mr17056262f8f.13.1753108171727;
        Mon, 21 Jul 2025 07:29:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdMHdDErkH0taKHE6JmcK2y3pk2Zphs0oPiq92bL4QDnYNXdsveOhyTkckwc/6TaCkllSQRg==
X-Received: by 2002:a5d:5c13:0:b0:3b5:dc2e:3cd6 with SMTP id ffacd0b85a97d-3b60e4d0250mr17056234f8f.13.1753108171228;
        Mon, 21 Jul 2025 07:29:31 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e8ab642sm157957205e9.36.2025.07.21.07.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 07:29:30 -0700 (PDT)
Message-ID: <bf090e9bb08cee60a30b5bd64e9a3c24da2571ec.camel@redhat.com>
Subject: Re: [PATCH 3/6] rv: Merge struct rv_reactor_def into struct
 rv_reactor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 21 Jul 2025 16:29:28 +0200
In-Reply-To: <b3493045647d0c486e1317c1ee2f2ce683b567db.1753091084.git.namcao@linutronix.de>
References: <cover.1753091084.git.namcao@linutronix.de>
	 <b3493045647d0c486e1317c1ee2f2ce683b567db.1753091084.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wbq4s-Y2jlqnrqYqzcxkNHfLcjgd-GGusqIvRXwVuXY_1753108172
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-07-21 at 11:47 +0200, Nam Cao wrote:
> Each struct rv_reactor has a unique struct rv_reactor_def associated
> with it. struct rv_reactor is statically allocated, while struct
> rv_reactor_def is dynamically allocated.
>=20
> This makes the code more complicated than it should be:
>=20
> =C2=A0 - Lookup is required to get the associated rv_reactor_def from
> rv_reactor
>=20
> =C2=A0 - Dynamic memory allocation is required for rv_reactor_def. This i=
s
> =C2=A0=C2=A0=C2=A0 harder to get right compared to static memory. For ins=
tance,
> there is an existing mistake: rv_unregister_reactor() does not free
> the memory allocated by rv_register_reactor(). This is fortunately
> not a real memory leak problem as rv_unregister_reactor() is never
> called.
>=20
> Simplify and merge rv_reactor_def into rv_reactor.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---

Also here, looks good to me, thanks!

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

> =C2=A0include/linux/rv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +-
> =C2=A0kernel/trace/rv/rv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 9 ----
> =C2=A0kernel/trace/rv/rv_reactors.c | 92 +++++++++++++++-----------------=
-
> --
> =C2=A03 files changed, 43 insertions(+), 63 deletions(-)
>=20
> diff --git a/include/linux/rv.h b/include/linux/rv.h
> index dba53aecdfab..c22c9b8c1567 100644
> --- a/include/linux/rv.h
> +++ b/include/linux/rv.h
> @@ -90,6 +90,9 @@ struct rv_reactor {
> =C2=A0=09const char=09=09*name;
> =C2=A0=09const char=09=09*description;
> =C2=A0=09__printf(1, 2) void=09(*react)(const char *msg, ...);
> +=09struct list_head=09list;
> +=09/* protected by the monitor interface lock */
> +=09int=09=09=09counter;
> =C2=A0};
> =C2=A0#endif
> =C2=A0
> @@ -101,7 +104,7 @@ struct rv_monitor {
> =C2=A0=09void=09=09=09(*disable)(void);
> =C2=A0=09void=09=09=09(*reset)(void);
> =C2=A0#ifdef CONFIG_RV_REACTORS
> -=09struct rv_reactor_def=09*rdef;
> +=09struct rv_reactor=09*reactor;
> =C2=A0=09__printf(1, 2) void=09(*react)(const char *msg, ...);
> =C2=A0=09bool=09=09=09reacting;
> =C2=A0#endif
> diff --git a/kernel/trace/rv/rv.h b/kernel/trace/rv/rv.h
> index f039ec1c9156..8c38f9dd41bc 100644
> --- a/kernel/trace/rv/rv.h
> +++ b/kernel/trace/rv/rv.h
> @@ -23,15 +23,6 @@ struct rv_interface {
> =C2=A0extern struct mutex rv_interface_lock;
> =C2=A0extern struct list_head rv_monitors_list;
> =C2=A0
> -#ifdef CONFIG_RV_REACTORS
> -struct rv_reactor_def {
> -=09struct list_head=09list;
> -=09struct rv_reactor=09*reactor;
> -=09/* protected by the monitor interface lock */
> -=09int=09=09=09counter;
> -};
> -#endif
> -
> =C2=A0struct dentry *get_monitors_root(void);
> =C2=A0int rv_disable_monitor(struct rv_monitor *mon);
> =C2=A0int rv_enable_monitor(struct rv_monitor *mon);
> diff --git a/kernel/trace/rv/rv_reactors.c
> b/kernel/trace/rv/rv_reactors.c
> index 7cc620a1be1a..2c7909e6d0e7 100644
> --- a/kernel/trace/rv/rv_reactors.c
> +++ b/kernel/trace/rv/rv_reactors.c
> @@ -70,12 +70,12 @@
> =C2=A0 */
> =C2=A0static LIST_HEAD(rv_reactors_list);
> =C2=A0
> -static struct rv_reactor_def *get_reactor_rdef_by_name(char *name)
> +static struct rv_reactor *get_reactor_rdef_by_name(char *name)
> =C2=A0{
> -=09struct rv_reactor_def *r;
> +=09struct rv_reactor *r;
> =C2=A0
> =C2=A0=09list_for_each_entry(r, &rv_reactors_list, list) {
> -=09=09if (strcmp(name, r->reactor->name) =3D=3D 0)
> +=09=09if (strcmp(name, r->name) =3D=3D 0)
> =C2=A0=09=09=09return r;
> =C2=A0=09}
> =C2=A0=09return NULL;
> @@ -86,9 +86,9 @@ static struct rv_reactor_def
> *get_reactor_rdef_by_name(char *name)
> =C2=A0 */
> =C2=A0static int reactors_show(struct seq_file *m, void *p)
> =C2=A0{
> -=09struct rv_reactor_def *rea_def =3D p;
> +=09struct rv_reactor *reactor =3D p;
> =C2=A0
> -=09seq_printf(m, "%s\n", rea_def->reactor->name);
> +=09seq_printf(m, "%s\n", reactor->name);
> =C2=A0=09return 0;
> =C2=A0}
> =C2=A0
> @@ -139,12 +139,12 @@ static const struct file_operations
> available_reactors_ops =3D {
> =C2=A0static int monitor_reactor_show(struct seq_file *m, void *p)
> =C2=A0{
> =C2=A0=09struct rv_monitor *mon =3D m->private;
> -=09struct rv_reactor_def *rdef =3D p;
> +=09struct rv_reactor *reactor =3D p;
> =C2=A0
> -=09if (mon->rdef =3D=3D rdef)
> -=09=09seq_printf(m, "[%s]\n", rdef->reactor->name);
> +=09if (mon->reactor =3D=3D reactor)
> +=09=09seq_printf(m, "[%s]\n", reactor->name);
> =C2=A0=09else
> -=09=09seq_printf(m, "%s\n", rdef->reactor->name);
> +=09=09seq_printf(m, "%s\n", reactor->name);
> =C2=A0=09return 0;
> =C2=A0}
> =C2=A0
> @@ -159,13 +159,13 @@ static const struct seq_operations
> monitor_reactors_seq_ops =3D {
> =C2=A0};
> =C2=A0
> =C2=A0static void monitor_swap_reactors_single(struct rv_monitor *mon,
> -=09=09=09=09=09 struct rv_reactor_def
> *rdef,
> +=09=09=09=09=09 struct rv_reactor *reactor,
> =C2=A0=09=09=09=09=09 bool reacting, bool nested)
> =C2=A0{
> =C2=A0=09bool monitor_enabled;
> =C2=A0
> =C2=A0=09/* nothing to do */
> -=09if (mon->rdef =3D=3D rdef)
> +=09if (mon->reactor =3D=3D reactor)
> =C2=A0=09=09return;
> =C2=A0
> =C2=A0=09monitor_enabled =3D mon->enabled;
> @@ -173,12 +173,12 @@ static void monitor_swap_reactors_single(struct
> rv_monitor *mon,
> =C2=A0=09=09rv_disable_monitor(mon);
> =C2=A0
> =C2=A0=09/* swap reactor's usage */
> -=09mon->rdef->counter--;
> -=09rdef->counter++;
> +=09mon->reactor->counter--;
> +=09reactor->counter++;
> =C2=A0
> -=09mon->rdef =3D rdef;
> +=09mon->reactor =3D reactor;
> =C2=A0=09mon->reacting =3D reacting;
> -=09mon->react =3D rdef->reactor->react;
> +=09mon->react =3D reactor->react;
> =C2=A0
> =C2=A0=09/* enable only once if iterating through a container */
> =C2=A0=09if (monitor_enabled && !nested)
> @@ -186,7 +186,7 @@ static void monitor_swap_reactors_single(struct
> rv_monitor *mon,
> =C2=A0}
> =C2=A0
> =C2=A0static void monitor_swap_reactors(struct rv_monitor *mon,
> -=09=09=09=09=C2=A0 struct rv_reactor_def *rdef, bool
> reacting)
> +=09=09=09=09=C2=A0 struct rv_reactor *reactor, bool
> reacting)
> =C2=A0{
> =C2=A0=09struct rv_monitor *p =3D mon;
> =C2=A0
> @@ -194,7 +194,7 @@ static void monitor_swap_reactors(struct
> rv_monitor *mon,
> =C2=A0=09=09list_for_each_entry_continue(p, &rv_monitors_list,
> list) {
> =C2=A0=09=09=09if (p->parent !=3D mon)
> =C2=A0=09=09=09=09break;
> -=09=09=09monitor_swap_reactors_single(p, rdef,
> reacting, true);
> +=09=09=09monitor_swap_reactors_single(p, reactor,
> reacting, true);
> =C2=A0=09=09}
> =C2=A0=09/*
> =C2=A0=09 * This call enables and disables the monitor if they were
> active.
> @@ -202,7 +202,7 @@ static void monitor_swap_reactors(struct
> rv_monitor *mon,
> =C2=A0=09 * All nested monitors are enabled also if they were off, we
> may refine
> =C2=A0=09 * this logic in the future.
> =C2=A0=09 */
> -=09monitor_swap_reactors_single(mon, rdef, reacting, false);
> +=09monitor_swap_reactors_single(mon, reactor, reacting, false);
> =C2=A0}
> =C2=A0
> =C2=A0static ssize_t
> @@ -211,7 +211,7 @@ monitor_reactors_write(struct file *file, const
> char __user *user_buf,
> =C2=A0{
> =C2=A0=09char buff[MAX_RV_REACTOR_NAME_SIZE + 2];
> =C2=A0=09struct rv_monitor *mon;
> -=09struct rv_reactor_def *rdef;
> +=09struct rv_reactor *reactor;
> =C2=A0=09struct seq_file *seq_f;
> =C2=A0=09int retval =3D -EINVAL;
> =C2=A0=09bool enable;
> @@ -243,16 +243,16 @@ monitor_reactors_write(struct file *file, const
> char __user *user_buf,
> =C2=A0
> =C2=A0=09retval =3D -EINVAL;
> =C2=A0
> -=09list_for_each_entry(rdef, &rv_reactors_list, list) {
> -=09=09if (strcmp(ptr, rdef->reactor->name) !=3D 0)
> +=09list_for_each_entry(reactor, &rv_reactors_list, list) {
> +=09=09if (strcmp(ptr, reactor->name) !=3D 0)
> =C2=A0=09=09=09continue;
> =C2=A0
> -=09=09if (rdef =3D=3D get_reactor_rdef_by_name("nop"))
> +=09=09if (strcmp(reactor->name, "nop"))
> =C2=A0=09=09=09enable =3D false;
> =C2=A0=09=09else
> =C2=A0=09=09=09enable =3D true;
> =C2=A0
> -=09=09monitor_swap_reactors(mon, rdef, enable);
> +=09=09monitor_swap_reactors(mon, reactor, enable);
> =C2=A0
> =C2=A0=09=09retval =3D count;
> =C2=A0=09=09break;
> @@ -299,23 +299,16 @@ static const struct file_operations
> monitor_reactors_ops =3D {
> =C2=A0
> =C2=A0static int __rv_register_reactor(struct rv_reactor *reactor)
> =C2=A0{
> -=09struct rv_reactor_def *r;
> +=09struct rv_reactor *r;
> =C2=A0
> =C2=A0=09list_for_each_entry(r, &rv_reactors_list, list) {
> -=09=09if (strcmp(reactor->name, r->reactor->name) =3D=3D 0) {
> +=09=09if (strcmp(reactor->name, r->name) =3D=3D 0) {
> =C2=A0=09=09=09pr_info("Reactor %s is already
> registered\n", reactor->name);
> =C2=A0=09=09=09return -EINVAL;
> =C2=A0=09=09}
> =C2=A0=09}
> =C2=A0
> -=09r =3D kzalloc(sizeof(struct rv_reactor_def), GFP_KERNEL);
> -=09if (!r)
> -=09=09return -ENOMEM;
> -
> -=09r->reactor =3D reactor;
> -=09r->counter =3D 0;
> -
> -=09list_add_tail(&r->list, &rv_reactors_list);
> +=09list_add_tail(&reactor->list, &rv_reactors_list);
> =C2=A0
> =C2=A0=09return 0;
> =C2=A0}
> @@ -350,26 +343,19 @@ int rv_register_reactor(struct rv_reactor
> *reactor)
> =C2=A0 */
> =C2=A0int rv_unregister_reactor(struct rv_reactor *reactor)
> =C2=A0{
> -=09struct rv_reactor_def *ptr, *next;
> =C2=A0=09int ret =3D 0;
> =C2=A0
> =C2=A0=09mutex_lock(&rv_interface_lock);
> =C2=A0
> -=09list_for_each_entry_safe(ptr, next, &rv_reactors_list, list)
> {
> -=09=09if (strcmp(reactor->name, ptr->reactor->name) =3D=3D 0)
> {
> -
> -=09=09=09if (!ptr->counter) {
> -=09=09=09=09list_del(&ptr->list);
> -=09=09=09} else {
> -=09=09=09=09printk(KERN_WARNING
> -=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "rv: the rv_reactor %s =
is in
> use by %d monitor(s)\n",
> -=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ptr->reactor->name, ptr=
-
> >counter);
> -=09=09=09=09printk(KERN_WARNING "rv: the
> rv_reactor %s cannot be removed\n",
> -=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ptr->reactor->name);
> -=09=09=09=09ret =3D -EBUSY;
> -=09=09=09=09break;
> -=09=09=09}
> -=09=09}
> +=09if (!reactor->counter) {
> +=09=09list_del(&reactor->list);
> +=09} else {
> +=09=09printk(KERN_WARNING
> +=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "rv: the rv_reactor %s is in =
use by %d
> monitor(s)\n",
> +=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reactor->name, reactor->count=
er);
> +=09=09printk(KERN_WARNING "rv: the rv_reactor %s cannot be
> removed\n",
> +=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reactor->name);
> +=09=09ret =3D -EBUSY;
> =C2=A0=09}
> =C2=A0
> =C2=A0=09mutex_unlock(&rv_interface_lock);
> @@ -469,8 +455,8 @@ int reactor_populate_monitor(struct rv_monitor
> *mon)
> =C2=A0=09/*
> =C2=A0=09 * Configure as the rv_nop reactor.
> =C2=A0=09 */
> -=09mon->rdef =3D get_reactor_rdef_by_name("nop");
> -=09mon->rdef->counter++;
> +=09mon->reactor =3D get_reactor_rdef_by_name("nop");
> +=09mon->reactor->counter++;
> =C2=A0=09mon->reacting =3D false;
> =C2=A0
> =C2=A0=09return 0;
> @@ -483,8 +469,8 @@ int reactor_populate_monitor(struct rv_monitor
> *mon)
> =C2=A0void reactor_cleanup_monitor(struct rv_monitor *mon)
> =C2=A0{
> =C2=A0=09lockdep_assert_held(&rv_interface_lock);
> -=09mon->rdef->counter--;
> -=09WARN_ON_ONCE(mon->rdef->counter < 0);
> +=09mon->reactor->counter--;
> +=09WARN_ON_ONCE(mon->reactor->counter < 0);
> =C2=A0}
> =C2=A0
> =C2=A0/*

