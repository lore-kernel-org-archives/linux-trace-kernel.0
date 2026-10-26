Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793019980;
	b=FYyRgDj0WclS9qWAWX8RTMAojKIcwwU404U5wpOJFVjZ5fBTK3yTDqCaur9hHh6QelSS
	 Ji+da90XQDUm13fEfuChTnTEo1nSAsyjh6JZOUF4aAguKS8sQXhe2Xf0raSUgKF/Pc3Dy
	 6glRdYMRkg9hBHfJlwylichdXwiO+fuiE/im3QlmhgtIsA2FecU1yb3DNLVrbk+ZqJ5gh
	 s2c6nsfddN7J5kY3AbQ9MDpQo13S3BqoT+lGvwAms9E6Vp4G3SSHSHpxk0tnKUwmpPIxC
	 p/epaaq8cIdDNvnc79nCpmjI6Ze/IJ78fRA7fcDn5TeI85z0IZy8pN8hXrg+AeOkzzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793019980;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=+JXUxmaxJiI7AmbALHuzSmGJQY1lasoLp4QRoUxkCDI=;
	b=X2zOb10qAVkdLVs8s6Ym37VKjFy9uHzKoW2biz0OLPUDJAeh/uE/GUw3e1iCGxGDv/Cd
	 hTLEnsTclV4+HyERlKZMbg/IjG9hQEB2Nl5MJ4IpfMf4tHkNekAGY0V8KkWLl3jnzmsyE
	 bC6PnbKyfFv+IckplYkqf8VYgBuMnEF1QedUwLmgI4b81NIRkBEwXu2Xuy7Rt0Wg0zd55
	 pXh6pFtXKLf19vjFfVvLLCLz0jvnAr3Rt2NHWNyr/+cwhvrFTjZnBtKANIm6DEmlWaR3f
	 AMl92MLI7p9X+zcvkzAtrRJ0FApBZVA0H/Cdr6fpT1vFribvx2Ciua1znFErd3WMdFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WPvVol5R;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BAA606A31A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 13:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53BAA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WPvVol5R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793019978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+JXUxmaxJiI7AmbALHuzSmGJQY1lasoLp4QRoUxkCDI=;
	b=WPvVol5R2lizCM02u4cG9F4i4Wu5xDKuipuJebBsTx+5aC1E0DWAocLAAv/F6Xn217QsUU
	n3T9nDh6uCvVpX+qyQVfC/9/D4nsrhC6Yz31+Z62MHW9Vdx7cnDc+WujVMXHWMr+o8JN6U
	s26P8UFa+o8cG3BAqGKT7n/IE7neNL0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-RuJlT6FEOqSmqL41v9Eatw-1; Mon, 26 Oct 2026 09:06:17 -0400
X-MC-Unique: RuJlT6FEOqSmqL41v9Eatw-1
X-Mimecast-MFC-AGG-ID: RuJlT6FEOqSmqL41v9Eatw_1793019976
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a1fa972b4fso15221965e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 06:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793019976; x=1793624776;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bCWVrjiZl9TQf8/Ty02OBVB4QF0zvuew8Fni+YiAYE4=;
        b=IB8M36zZZu36qwe4XVQkBJtfRDwvD0lIoHkJdvSPFCVFtAZcf1e1kY+K2fUM0qaxcI
         Rjuyh8ZKdDC697vIT3+rOJ3zsfWWDRSCUOwB6/7BypiLCqSjRcOXVIuZMVYjMRC4m5aB
         evaGIPcpLBZTeJi1B/xxEa/6pyxwl7ZSSmkQ5FL+FX0trIJhPE5weC2H6zW6IyAAXtr3
         rmgGkhvPd+y47Fg5JEiQ/MOdwHCZW5aYE3ST7PGCc9VxuISteAFPdqhLMbfZPtas2yQI
         0PZz/Ud5zFi1mlaqbRfjuZoKgmK7QfHbSkq+2EH6jGez9uwoF0I0v9aTDhj5DjmRowdw
         7XDw==
X-Forwarded-Encrypted: i=1; AKwUvBxKOn92vpGnNXSlrXY9XEfGUwjxZm+D9B02/mpKqb62gkfIgI5cGu5UeL1si114KnDGAtusRtFvhlDnxWwpBrKsizU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLIRBMo6UCR6B64fMU92Ce+73lLuNVZEywhgrNrv8mOqEQDH5g2
	ywLVXL/xWiz6fIVtlQMZ9nE2KDO/FXDRXXJ/y6WfWJ3YnTavswXgXaan/kkRQQE31FxY+RHEacZ
	1VPTRr+iXv4Qknau9bHd9D/Fbf+md8wGZisqdIPZh+L9QJ1uM5Z3E+4/5vsbVwbAIfRAdL44OcZ
	8X31P+5Q==
X-Gm-Gg: AYBFou2Veo28OZ3O8/d5OXpdMPiPykA/1SPD/n3tA5C9CAR4aJtrPetfabLGlE7RNH7
	YwmyGCP9ySsb9CFqNzM6HyEI/+JPDIAFTEY/Yn0XNI9fHnJgZf2AxVLmU1oioREjBNNBlX5QcAn
	BY1lbCYfZBFI45HEi+3Ay9HGgS0Rv5/WM2yhLZhGTyvcQLoYbhXQ1JpInSAcrdUJnHLTVxDD/uD
	H9XKrCf4ZQshQePx5kQQTlgb6eJIPiPLiQ235coASsI46kYiWlgf/5xgnsi7p0mQBXQ5fR4iir9
	OxkD7/VMuUdJaMT9/dXTcXwEu75/ZADLVEfshQ9PILcFVKcPyiPNMzGSFlyCMq4d2V1ggeVqD8e
	0+zd1+KkUrIJqirf5rt3Te2/28w7a
X-Received: by 2002:a05:600c:474a:b0:4a3:12fb:1ef1 with SMTP id 5b1f17b1804b1-4a35acaa6e7mr125345295e9.29.1793019975786;
        Mon, 26 Oct 2026 06:06:15 -0700 (PDT)
X-Received: by 2002:a05:600c:474a:b0:4a3:12fb:1ef1 with SMTP id 5b1f17b1804b1-4a35acaa6e7mr125344445e9.29.1793019975155;
        Mon, 26 Oct 2026 06:06:15 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.133.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a30e11bsm231268565e9.1.2026.10.26.06.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 06:06:14 -0700 (PDT)
Message-ID: <2c2ecf44e7aa2d6a9bd8f926557bf745cad3d6fb.camel@redhat.com>
Subject: Re: [PATCH v7 00/14] rv: Add task latency over budget RV monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 14:06:13 +0100
In-Reply-To: <462351c6a891d1a2d57d2589124caf939225f9b2.camel@redhat.com>
References: <cover.1791745088.git.wen.yang@linux.dev>
	 <462351c6a891d1a2d57d2589124caf939225f9b2.camel@redhat.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZVd8MF9CxE9b2cfdwWluoJPJlfhEsCdChTf6I9Ej8JI_1793019976
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-10-26 at 12:05 +0100, Gabriele Monaco wrote:
> By the way there has been a running discussion about keeping the C files =
for
> the monitors as close as possible to the DOT representation, with a long-=
term
> goal to extend the DOT to represent everything and have logic represented
> there too (at least simple trace filters).
> ...
> These are general guidelines, the C files cannot yet be a 1-to-1 product =
of
> the model, but shouldn't be a completely different story either.

To push this even further, why don't we get the framework allocate also the
tlob_record ?
I played a bit to adapt the PER_OBJ things to accept non-pointer targets. N=
ow
this is far from clean and is /not/ a recommendation over how the API shoul=
d look
like, but it seems to work and simplified tlob even further.

Nothing forbids us to embed data with the monitor state also for other type=
s in
the future (besides in-kernel PER_TASK, that must be fixed).

What do you think?

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 04caaf529034..4677e19b228d 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -23,6 +23,17 @@
  *                   must run in task context; other handlers only call
  *                   da_handle_event() and never allocate.
  * DA_ALLOC_MANUAL - caller pre-inserts storage; framework links the targe=
t.
+ *
+ * The target type: a PER_OBJ monitor usually typedefs monitor_target itse=
lf,
+ * as a pointer to the monitored object (borrowed: the object exists
+ * independently of the monitor and outlives the storage).  A monitor whos=
e
+ * target is monitor-owned data can instead define DA_OBJ_EMBEDDED_TYPE wi=
th
+ * a complete struct type: the framework then derives monitor_target as a
+ * pointer to it, embeds one instance in each per-object storage, and
+ * allocates and frees it together with the storage.  On storage creation =
the
+ * caller-supplied target is shallow-copied into the storage before it is
+ * published, so it may be a fully initialised stack object.  Do not defin=
e
+ * monitor_target by hand when using DA_OBJ_EMBEDDED_TYPE.
  */
 #define DA_ALLOC_AUTO   0
 #define DA_ALLOC_POOL   1
@@ -61,6 +72,10 @@
 #include <linux/slab.h>
 #include <linux/hashtable.h>
=20
+#if defined(DA_OBJ_EMBEDDED_TYPE) && RV_MON_TYPE !=3D RV_MON_PER_OBJ
+#error "DA_OBJ_EMBEDDED_TYPE is only supported by RV_MON_PER_OBJ monitors"
+#endif
+
 /*
  * Per-cpu variables require a unique name although static in some
  * configurations (e.g. alpha modules).
@@ -463,9 +478,24 @@ static inline void da_monitor_destroy(void)
  * Functions to define, init and get a per-object monitor.
  */
=20
+#ifdef DA_OBJ_EMBEDDED_TYPE
+/*
+ * Framework-owned target: one instance is embedded in each storage and
+ * allocated/freed with it.  monitor_target keeps pointer semantics, but
+ * da_get_target() points into the storage rather than to a borrowed objec=
t.
+ * The header derives the typedef: do not define monitor_target by hand.
+ */
+typedef DA_OBJ_EMBEDDED_TYPE *monitor_target;
+#endif
+
 struct da_monitor_storage {
 =09da_id_type id;
+#ifdef DA_OBJ_EMBEDDED_TYPE
+=09DA_OBJ_EMBEDDED_TYPE target;
+=09bool filled;
+#else
 =09monitor_target target;
+#endif
 =09union rv_task_monitor rv;
 =09struct hlist_node node;
 =09struct rcu_head rcu;
@@ -476,6 +506,38 @@ struct da_monitor_storage {
 #endif
 static DEFINE_HASHTABLE(da_monitor_ht, DA_MONITOR_HT_BITS);
=20
+#ifdef DA_OBJ_EMBEDDED_TYPE
+
+#define TARGET_PTR(storage) &storage->target
+
+static inline bool da_storage_is_empty(struct da_monitor_storage *mon_stor=
age)
+{
+=09return !smp_load_acquire(&mon_storage->filled);
+}
+static inline void da_storage_set_target(struct da_monitor_storage *mon_st=
orage,
+=09=09=09=09=09 monitor_target target)
+{
+=09if (WARN_ON_ONCE(!target))
+=09=09return;
+
+=09memcpy(&mon_storage->target, target, sizeof(mon_storage->target));
+=09smp_store_release(&mon_storage->filled, true);
+}
+#else
+
+#define TARGET_PTR(storage) storage->target
+
+static inline bool da_storage_is_empty(struct da_monitor_storage *mon_stor=
age)
+{
+=09return !TARGET_PTR(mon_storage);
+}
+static inline void da_storage_set_target(struct da_monitor_storage *mon_st=
orage,
+=09=09=09=09=09 monitor_target target)
+{
+=09mon_storage->target =3D target;
+}
+#endif
+
 /*
  * da_create_empty_storage - pre-allocate an empty storage
  */
@@ -513,7 +575,7 @@ static inline struct da_monitor *da_create_storage(da_i=
d_type id,
 =09if (!mon_storage)
 =09=09return NULL;
=20
-=09mon_storage->target =3D target;
+=09da_storage_set_target(mon_storage, target);
 =09return &mon_storage->rv.da_mon;
 }
=20
@@ -549,7 +611,7 @@ static struct da_monitor *da_get_monitor(da_id_type id,=
 monitor_target target)
  */
 static inline monitor_target da_get_target(struct da_monitor *da_mon)
 {
-=09return container_of(da_mon, struct da_monitor_storage, rv.da_mon)->targ=
et;
+=09return TARGET_PTR(container_of(da_mon, struct da_monitor_storage, rv.da=
_mon));
 }
=20
 /*
@@ -582,8 +644,11 @@ static inline struct da_monitor *da_fill_empty_storage=
(da_id_type id,
 =09=09=09=09=09=09       monitor_target target,
 =09=09=09=09=09=09       struct da_monitor *da_mon)
 {
-=09if (unlikely(da_mon && !da_get_target(da_mon)))
-=09=09container_of(da_mon, struct da_monitor_storage, rv.da_mon)->target =
=3D target;
+=09struct da_monitor_storage *mon_storage =3D
+=09=09container_of(da_mon, struct da_monitor_storage, rv.da_mon);
+
+=09if (unlikely(da_mon && da_storage_is_empty(mon_storage)))
+=09=09da_storage_set_target(mon_storage, target);
 =09return da_mon;
 }
=20
@@ -599,7 +664,7 @@ static inline monitor_target da_get_target_by_id(da_id_=
type id)
=20
 =09if (unlikely(!mon_storage))
 =09=09return NULL;
-=09return mon_storage->target;
+=09return TARGET_PTR(mon_storage);
 }
=20
 static void da_kfree_cb(struct rcu_head *head)
@@ -645,7 +710,7 @@ da_create_pool_storage(da_id_type id, monitor_target ta=
rget,
 =09memset(mon_storage, 0, sizeof(*mon_storage));
=20
 =09mon_storage->id =3D id;
-=09mon_storage->target =3D target;
+=09da_storage_set_target(mon_storage, target);
=20
 =09hash_add_rcu(da_monitor_ht, &mon_storage->node, id);
 =09return &mon_storage->rv.da_mon;

