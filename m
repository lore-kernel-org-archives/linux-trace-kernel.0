Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0289C1D540
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Apr 2025 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744374692; cv=none; b=ELnIQfD9R37ufxH26xhroLdyafRNS2d6y3YNP/pteNRZMoareMHRNiEPg7hiG7uDLtgZ3ofAuDfo6y2IAIxcGzg3gm7YEHxWbZ9GCIulp+RjdVVZ3yVWLV0M/eDr3e5BWFWuFyb8WuLdqBPPTqsHjyXOMoT4tvTBfdAczYJCQh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744374692; c=relaxed/simple;
	bh=oTxD2B5RSFwuB83UxvVUpDGVjm9HhjuiYbJmuIFsqG0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I/qHBGywrMcyDQEWCcNHWEItaKffjPMtCtC18ecETiGSHSqBGNDOyfJL/fyT0FGIZc5YNo+YsPq4vdIOU9g8IKKwVqBgPC3GTe//tAyAGgdkLUoRKzR0bQkmdKpKWGsJBwuvobV96/Qg98bhWDBC1IG05roFWIXeig0zZS3RH7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q9qnsUGx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q9qnsUGx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744374689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oTxD2B5RSFwuB83UxvVUpDGVjm9HhjuiYbJmuIFsqG0=;
	b=Q9qnsUGxotu9QQqky4oGMo7da+ytIXG1kVEztcQu3EkdZFFtGKoG/pdUiIfQQxZ9wejDQS
	OZWEskhtqcX5uijZ/kuMiSbbySGjPxmjHyCNU6QZQRTpvvpJnJhYGJXsrQEHJdqQFx2Bai
	LL9LuS+PNQv25bibhqJFV58Cj070/7o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-YBbDSYCkPaaslRUSTivXCw-1; Fri, 11 Apr 2025 08:31:28 -0400
X-MC-Unique: YBbDSYCkPaaslRUSTivXCw-1
X-Mimecast-MFC-AGG-ID: YBbDSYCkPaaslRUSTivXCw_1744374687
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-391345e3aa3so1074090f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Apr 2025 05:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744374687; x=1744979487;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GJEeKS7xxB01iKq/G87oXV/bErhCVG//vypcEKNjGjk=;
        b=Ms7cupQcd0X8gtzzurRfT9brmL/tspLSKzNAd5nQIa/lt9GXeO6ZdYxeiDaOM74QLQ
         yp8KumC5VAyer4zTOTBKdksac5TZsTR/yGc6UV61ai+ZpZrSlRoCEN9aqbB1wzAo4pfN
         3L6tHNUg/8hoyCZpYOYpjSAyWq+ucujL1nmywB3ny58YXF1NLrFqqb21LcjCcizGjjF/
         95Pp4ZI2Ku7gUTI1Q6Kz7DZKmDCYRSmxcMCDm53GLwc/sKhLXpS0PYCrHTmbjVShq1KF
         chtXD2sa2f3c6WJNEG4dvJ1YAN50IP1Vb1hBDPzcCYwQv/26IiGHIM0ILn1kKeSHZ2pw
         QXuA==
X-Forwarded-Encrypted: i=1; AJvYcCXTw1u6IrMcDLsjhuW/ZWmPICYNpaK74I0+ys2QV1vUqjUZLXnIfQLxoe5ZavxDT624Zy4Tetfuc9WCLpUjOWmjTpE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5BIhHcLalyPnCMGZM1MfG2MY8TCFM2yOMYdWIuL4QRZYVhgd2
	dg7Mgg7pYZK5/WW5J+8FCkX1SFkzxT5qH3ZxM64g0TZY3VVjmxkK5T1V01XofjwbDTRlrOSPX5i
	S5k1F2yP4PNuqWKU3OXej7XSp1n/E7G6h/Qxr9M2shLaT6sjzm4lnD9y52aBOII4Ou3LFYQ==
X-Gm-Gg: ASbGnctNtdZslG0mEH3peUSiolIL7JQP5yJH9tnLyHe3iL1yVOm9OawmB6fesqHQ7gR
	USeVRpOVGfnhnxiTokOMW+jfnt9qonnKWJ0SyP2fAXqCk1kHsUe9+vNPJPhIQkYk+bzLe2E/D9z
	q96o5Ahn1+GKsX5SXSs5QC+22o75Ie5A/BCspOrCe6NESlponzmPEgqOFyEhDAoTzez+Iqft3pf
	6MBuLJUQ6ZcXaXNScar9cPCWpDTBeR2SMNMUN+nvTCmwTUsfYjzZGINk6VCeEgIvcV6mc7w7lnv
	+1eqhxXExd1+NM/f4bzd13uAo+4YufAiIynYSA==
X-Received: by 2002:a05:6000:2ab:b0:391:2fe4:de0a with SMTP id ffacd0b85a97d-39ea51d101dmr2302714f8f.2.1744374687191;
        Fri, 11 Apr 2025 05:31:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHgSNQW/JrpVf7gPQ5mPM0FUzJgYSItETaWW3fszkPMzJM3Wg+Up54VDrNGuVjgCiRDthFxA==
X-Received: by 2002:a05:6000:2ab:b0:391:2fe4:de0a with SMTP id ffacd0b85a97d-39ea51d101dmr2302665f8f.2.1744374686645;
        Fri, 11 Apr 2025 05:31:26 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae96c123sm1943076f8f.36.2025.04.11.05.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 05:31:26 -0700 (PDT)
Message-ID: <3856012ded193df3685d9a11724612896165179a.camel@redhat.com>
Subject: Re: [PATCH v2 22/22] rv: Allow to configure the number of per-task
 monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de
Date: Fri, 11 Apr 2025 14:31:19 +0200
In-Reply-To: <2591d725ec3dddfa27ad1826e7440fca71671770.1744355018.git.namcao@linutronix.de>
References: <cover.1744355018.git.namcao@linutronix.de>
	 <2591d725ec3dddfa27ad1826e7440fca71671770.1744355018.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T3LNiwDMBn9FIz383JsUAltwKhI48TfduKozt5asDYw_1744374687
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-04-11 at 09:37 +0200, Nam Cao wrote:
> Now that there are 2 monitors for real-time applications, users may
> want to
> enable both of them simultaneously. Make the number of per-task
> monitor
> configurable. Default it to 2 for now.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> =C2=A0include/linux/rv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0include/linux/sched.h=C2=A0=C2=A0 | 8 +++-----
> =C2=A0kernel/trace/rv/Kconfig | 9 +++++++++
> =C2=A0kernel/trace/rv/rv.c=C2=A0=C2=A0=C2=A0 | 8 ++++----
> =C2=A04 files changed, 17 insertions(+), 10 deletions(-)
>=20
> diff --git a/include/linux/rv.h b/include/linux/rv.h
> index c8320fa3a94b..204436a73bee 100644
> --- a/include/linux/rv.h
> +++ b/include/linux/rv.h
> @@ -75,7 +75,7 @@ static inline bool rv_ltl_all_atoms_known(struct
> ltl_monitor *mon)
> =C2=A0 * these are justified.
> =C2=A0 */
> =C2=A0#define RV_PER_TASK_MONITORS=09=091

We could get rid of RV_PER_TASK_MONITORS too I guess.

Rest looks good, thanks.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

> -#define RV_PER_TASK_MONITOR_INIT=09(RV_PER_TASK_MONITORS)
> +#define
> RV_PER_TASK_MONITOR_INIT=09(CONFIG_RV_PER_TASK_MONITORS)
> =C2=A0
> =C2=A0union rv_task_monitor {
> =C2=A0=09struct da_monitor=09da_mon;
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 45be0fa7a5cc..560782493292 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1623,12 +1623,10 @@ struct task_struct {
> =C2=A0
> =C2=A0#ifdef CONFIG_RV
> =C2=A0=09/*
> -=09 * Per-task RV monitor. Nowadays fixed in
> RV_PER_TASK_MONITORS.
> -=09 * If we find justification for more monitors, we can think
> -=09 * about adding more or developing a dynamic method. So far,
> -=09 * none of these are justified.
> +=09 * Per-task RV monitor, fixed in
> CONFIG_RV_PER_TASK_MONITORS.
> +=09 * If memory becomes a concern, we can think about a dynamic
> method.
> =C2=A0=09 */
> -=09union rv_task_monitor=09=09rv[RV_PER_TASK_MONITORS];
> +=09union
> rv_task_monitor=09=09rv[CONFIG_RV_PER_TASK_MONITORS];
> =C2=A0#endif
> =C2=A0
> =C2=A0#ifdef CONFIG_USER_EVENTS
> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> index 942d57575e67..c11bf7e61ebf 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> @@ -32,6 +32,15 @@ menuconfig RV
> =C2=A0=09=C2=A0 For further information, see:
> =C2=A0=09=C2=A0=C2=A0=C2=A0 Documentation/trace/rv/runtime-verification.r=
st
> =C2=A0
> +config RV_PER_TASK_MONITORS
> +=09int "Maximum number of per-task monitor"
> +=09depends on RV
> +=09range 1 8
> +=09default 2
> +=09help
> +=09=C2=A0 This option configures the maximum number of per-task RV
> monitors that can run
> +=09=C2=A0 simultaneously.
> +
> =C2=A0source "kernel/trace/rv/monitors/wip/Kconfig"
> =C2=A0source "kernel/trace/rv/monitors/wwnr/Kconfig"
> =C2=A0source "kernel/trace/rv/monitors/sched/Kconfig"
> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index d493fddf411f..ebd4b4b228bf 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c
> @@ -165,7 +165,7 @@ struct dentry *get_monitors_root(void)
> =C2=A0LIST_HEAD(rv_monitors_list);
> =C2=A0
> =C2=A0static int task_monitor_count;
> -static bool task_monitor_slots[RV_PER_TASK_MONITORS];
> +static bool task_monitor_slots[CONFIG_RV_PER_TASK_MONITORS];
> =C2=A0
> =C2=A0int rv_get_task_monitor_slot(void)
> =C2=A0{
> @@ -173,12 +173,12 @@ int rv_get_task_monitor_slot(void)
> =C2=A0
> =C2=A0=09lockdep_assert_held(&rv_interface_lock);
> =C2=A0
> -=09if (task_monitor_count =3D=3D RV_PER_TASK_MONITORS)
> +=09if (task_monitor_count =3D=3D CONFIG_RV_PER_TASK_MONITORS)
> =C2=A0=09=09return -EBUSY;
> =C2=A0
> =C2=A0=09task_monitor_count++;
> =C2=A0
> -=09for (i =3D 0; i < RV_PER_TASK_MONITORS; i++) {
> +=09for (i =3D 0; i < CONFIG_RV_PER_TASK_MONITORS; i++) {
> =C2=A0=09=09if (task_monitor_slots[i] =3D=3D false) {
> =C2=A0=09=09=09task_monitor_slots[i] =3D true;
> =C2=A0=09=09=09return i;
> @@ -194,7 +194,7 @@ void rv_put_task_monitor_slot(int slot)
> =C2=A0{
> =C2=A0=09lockdep_assert_held(&rv_interface_lock);
> =C2=A0
> -=09if (slot < 0 || slot >=3D RV_PER_TASK_MONITORS) {
> +=09if (slot < 0 || slot >=3D CONFIG_RV_PER_TASK_MONITORS) {
> =C2=A0=09=09WARN_ONCE(1, "RV releasing an invalid slot!: %d\n",
> slot);
> =C2=A0=09=09return;
> =C2=A0=09}

