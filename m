Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738721BDCF
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Mar 2025 06:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741762080; cv=none; b=ExkdG3CNjGHtd8NSyRqv2Qmb21OMMVX8sjW6yhxgvZwRYKHIszqobCmt4ILL1MZC9ECLue1Ou6o1W8+7BBq949RjSdD1ge+TuJj3vNXhdxWce2M/HZP9/+fycaHfBfcs9eeY1wb3zFQJ1GzbdVd52QMFi6ZHpuzfc37UjcjCbMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741762080; c=relaxed/simple;
	bh=U3ceq+syDYtWO8u7NNWa27DSpBgMd1ER73w3pg0kfTY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QSpbV95CZhirPxP/Zjq+WZvlavY/bCUgIu2vPS677xx/vJ0hIyqkLkLRS4EKOkTrU++33HmRKz1C7skL6/oS3zVD2TTPE0qywD1VUPl/TCmXkVXpFnkcD/hL3OO0T/mqDYRIwkY8aWI1RCv03t8NjtFAv3pBIyYQbUoitrSIQyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YAD2nrPe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YAD2nrPe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741762077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=U3ceq+syDYtWO8u7NNWa27DSpBgMd1ER73w3pg0kfTY=;
	b=YAD2nrPeSWVV0gqpX6dFRaEPtYW47MWQeIYa34CX+Tdpzlb4npvKVw/fMX86n/SmcDvbqE
	/Xpx+wdUyuZSnr8gj54QPHLT36ohX/T1COhauZfcxU8Nz6q/uc8KollbzlFhECxv0RRmTw
	/vLY3DlcWO4gKYuaDeyG+gqBvoVqyn8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-KlJGkCmSNxuG6LOp-KLGrw-1; Wed, 12 Mar 2025 02:47:56 -0400
X-MC-Unique: KlJGkCmSNxuG6LOp-KLGrw-1
X-Mimecast-MFC-AGG-ID: KlJGkCmSNxuG6LOp-KLGrw_1741762075
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43bd0586a73so52356535e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Mar 2025 23:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741762075; x=1742366875;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8elTqnMhlN+wclUvDN3zVrvsLJk0vx8u9dC0NXLMmO4=;
        b=Z8GdaRVKlB3v8kDyZE5WOrlSHHZTcbQLUvTmP1mRzR3KTcMVRHgpUIdnHC005qItbi
         yRA5xUFCoUgbewgg00jjZhOd5GcR+ITdn//YLEPVcj9yAtQUfCcdlI5hz+VtFLM7S/ep
         DNTQ5/lZ0YXZbvdjq8d9LH5On5alH+Z35E3qfCBads+i7gdVOY1pw1d9aMrUWxOQzi4L
         Tl3yOngW8s5/4vNc7365IjOtkgZVLZav+FUyUqVVmEprzL+6qrVEb8Jc7eylFYE6yB7W
         j9w7+4F1BX0o5lwK1Pw7AZNTYCpp6pBBzEB3pfYx2BSj4JQpszJzTrE7BHizwfi8eGy1
         fXSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH4/C6FB0qk3/K6AceYJGDIIK0b/FXP5sIisxQOmexkcd7RVG9wx2KO+oKZp0UFZqmmGNBBNcQGds1UrT3h+dFLvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEmpCumCrsyr+Ewcpq1H66TwcPwXQuf3Xaqk70HUMpcpYcSWIz
	DU2AwRRAruvys5MpnnGbzx1rhxb451nIycfjf5HBa3PFse66SgkpE0ffn06Da/i8XJp4ngEWUWA
	rMXyhnszEnxmPGqrr1f1yWSseQDKNQ3ouRfO4nvmKIm7vAg1BxKWlpvfZRrntLUuZyLf3JzNWns
	pFcL1D
X-Gm-Gg: ASbGncv13OR2TH29NzJIW0lyLJJlquUn6fdx8N7mmRlK6yemBJB/boSFCivKOGWsG6g
	WqVHm3UlkcW5nC/Madlix+PlNCC0aUGqlNwz5NC9jX/8FY+UtKh6jKeJv7CsTx3MfmOayxLHGsM
	261wVgCtX6oomFyBdaOpr4bOwXWiTrYC5YqVcPqbLiyBF1po+5TRqXNyuHI0NU0vIJMyOAZ+puf
	i02Y/E/pAIhntP+MQbMDrDzWW99gsSNiGYCcTSrrPUD8hzVJ3eAbIjvnly/1OBu0aw89Bai7nMH
	b32XIsKEeNl0xUL6t1cGtW20WuUbaf8OTSc7vTFKAw==
X-Received: by 2002:a05:600c:46d3:b0:439:9424:1b70 with SMTP id 5b1f17b1804b1-43c602223f0mr210029005e9.30.1741762074564;
        Tue, 11 Mar 2025 23:47:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdut7Ymehc0NCBpGtvlWCULoSlwnI6hwo85bDkRrW/gssEMXgyKGl9NydD8bJd0V0KOUOGLw==
X-Received: by 2002:a05:600c:46d3:b0:439:9424:1b70 with SMTP id 5b1f17b1804b1-43c602223f0mr210028745e9.30.1741762074018;
        Tue, 11 Mar 2025 23:47:54 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c019557sm20701573f8f.50.2025.03.11.23.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 23:47:52 -0700 (PDT)
Message-ID: <035d1f1a92f15bfa60d2d133131dd8a25b3c78e4.camel@redhat.com>
Subject: Re: [PATCH 03/10] rv: Add infrastructure for linear temporal logic
 monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	john.ogness@linutronix.de, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 12 Mar 2025 07:47:50 +0100
In-Reply-To: <0b03a7d779707c598068d6ec00f3e5a19de336d8.1741708239.git.namcao@linutronix.de>
References: <cover.1741708239.git.namcao@linutronix.de>
	 <0b03a7d779707c598068d6ec00f3e5a19de336d8.1741708239.git.namcao@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: 58N2eEAWfbe16uRpKg3wC_QDpM6adWM9tU3Fyuh6XPE_1741762075
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-03-11 at 18:05 +0100, Nam Cao wrote:
> Prepare the infrastructure for linear temporal logic monitors:
>=20
> =C2=A0 - add scripts for generating the monitors
> =C2=A0 - implement data structures
>=20
> For details, see:
> Documentation/trace/rv/linear_temporal_logic.rst
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---

Thanks for this. It's great to have a new type of monitor!
I'll play with this a bit more, but please see my initial comments.

> =C2=A0.../trace/rv/linear_temporal_logic.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 73 +++
> =C2=A0include/linux/rv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 26 +-
> =C2=A0kernel/fork.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 5 +-
> =C2=A0tools/verification/ltl2ba/.gitignore=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
> =C2=A0tools/verification/ltl2ba/generate.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 154 +++++
> =C2=A0tools/verification/ltl2ba/ltl.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 556
> ++++++++++++++++++
> =C2=A0tools/verification/ltl2ba/template.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 131 +++++
> =C2=A0tools/verification/ltl2ba/template.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 157 +++++
> =C2=A08 files changed, 1097 insertions(+), 8 deletions(-)
> =C2=A0create mode 100644 Documentation/trace/rv/linear_temporal_logic.rst
> =C2=A0create mode 100644 tools/verification/ltl2ba/.gitignore
> =C2=A0create mode 100755 tools/verification/ltl2ba/generate.py
> =C2=A0create mode 100644 tools/verification/ltl2ba/ltl.py
> =C2=A0create mode 100644 tools/verification/ltl2ba/template.c
> =C2=A0create mode 100644 tools/verification/ltl2ba/template.h
>=20
> diff --git a/Documentation/trace/rv/linear_temporal_logic.rst
> b/Documentation/trace/rv/linear_temporal_logic.rst
> new file mode 100644
> index 000000000000..9b0ce6a143ec
> --- /dev/null
> +++ b/Documentation/trace/rv/linear_temporal_logic.rst

> [...]
>=20
> diff --git a/include/linux/rv.h b/include/linux/rv.h
> index 5482651ed020..6de4f93b390e 100644
> --- a/include/linux/rv.h
> +++ b/include/linux/rv.h
> @@ -10,6 +10,8 @@
> =C2=A0#define MAX_DA_NAME_LEN=0924
> =C2=A0
> =C2=A0#ifdef CONFIG_RV
> +#include <linux/types.h>
> +
> =C2=A0/*
> =C2=A0 * Deterministic automaton per-object variables.
> =C2=A0 */
> @@ -18,6 +20,24 @@ struct da_monitor {
> =C2=A0=09unsigned int=09curr_state;
> =C2=A0};
> =C2=A0
> +enum ltl_truth_value {
> +=09LTL_FALSE,
> +=09LTL_TRUE,
> +=09LTL_UNDETERMINED,
> +};
> +
> +/*
> + * In the future, if the number of atomic propositions or the custom
> data size is larger, we can
> + * switch to dynamic allocation. For now, the code is simpler this
> way.
> + */
> +#define RV_MAX_LTL_ATOM 10
> +#define RV_MAX_DATA_SIZE 16
> +struct ltl_monitor {
> +=09unsigned int=09=09state;
> +=09enum ltl_truth_value=09atoms[RV_MAX_LTL_ATOM];
> +=09u8=09=09=09data[RV_MAX_DATA_SIZE];
> +};
> +
> =C2=A0/*
> =C2=A0 * Per-task RV monitors count. Nowadays fixed in
> RV_PER_TASK_MONITORS.
> =C2=A0 * If we find justification for more monitors, we can think about
> @@ -27,11 +47,9 @@ struct da_monitor {
> =C2=A0#define RV_PER_TASK_MONITORS=09=091
> =C2=A0#define RV_PER_TASK_MONITOR_INIT=09(RV_PER_TASK_MONITORS)
> =C2=A0
> -/*
> - * Futher monitor types are expected, so make this a union.
> - */
> =C2=A0union rv_task_monitor {
> -=09struct da_monitor da_mon;
> +=09struct da_monitor=09da_mon;
> +=09struct ltl_monitor=09ltl_mon;
> =C2=A0};

This adds quite some memory overhead if we have multiple per-task
monitors (we might in the future) and we don't use this ltl monitors.
What about keeping it conditionally compiled out?
You could define the struct only if e.g. CONFIG_RV_LTL_MONITORS is set,
select it with any LTL monitor via Kconfig, then glue it somehow to
have it readable.

> =C2=A0
> =C2=A0#ifdef CONFIG_RV_REACTORS
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 735405a9c5f3..5d6c1caca702 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2127,10 +2127,7 @@ static void copy_oom_score_adj(u64
> clone_flags, struct task_struct *tsk)
> =C2=A0#ifdef CONFIG_RV
> =C2=A0static void rv_task_fork(struct task_struct *p)
> =C2=A0{
> -=09int i;
> -
> -=09for (i =3D 0; i < RV_PER_TASK_MONITORS; i++)
> -=09=09p->rv[i].da_mon.monitoring =3D false;
> +=09memset(p->rv, 0, sizeof(p->rv));
> =C2=A0}
> =C2=A0#else
> =C2=A0#define rv_task_fork(p) do {} while (0)
> diff --git a/tools/verification/ltl2ba/.gitignore
> b/tools/verification/ltl2ba/.gitignore
> new file mode 100644
> index 000000000000..9c47b9724860
> --- /dev/null
> +++ b/tools/verification/ltl2ba/.gitignore
> @@ -0,0 +1,3 @@
> +__pycache__/
> +parsetab.py
> +parser.out
> diff --git a/tools/verification/ltl2ba/generate.py
> b/tools/verification/ltl2ba/generate.py
> new file mode 100755
> index 000000000000..52d5b3618e64
> --- /dev/null
> +++ b/tools/verification/ltl2ba/generate.py

You may want to rename this script to something more unique, just in
case one day we decide to make it possible to install this generator on
the system (like dot2k/dot2c).

>=20
> diff --git a/tools/verification/ltl2ba/ltl.py
> b/tools/verification/ltl2ba/ltl.py
> new file mode 100644
> index 000000000000..aa3a11d78a8e
> --- /dev/null
> +++ b/tools/verification/ltl2ba/ltl.py
>=20
> diff --git a/tools/verification/ltl2ba/template.c
> b/tools/verification/ltl2ba/template.c
> new file mode 100644
> index 000000000000..31c5a209d71d
> --- /dev/null
> +++ b/tools/verification/ltl2ba/template.c
> diff --git a/tools/verification/ltl2ba/template.h
> b/tools/verification/ltl2ba/template.h
> new file mode 100644
> index 000000000000..65d342891e70
> --- /dev/null
> +++ b/tools/verification/ltl2ba/template.h
> @@ -0,0 +1,157 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * This file is generated, do not edit.
> + *
> + * This file includes necessary functions to glue the Buchi
> automaton and the kernel together.
> + * Some of these functions must be manually implemented (look for
> "Must be implemented", or just
> + * let the compiler tells you).
> + *
> + * Essentially, you need to manually define the meaning of the
> atomic propositions in the LTL
> + * property. The primary function for that is
> rv_%%MODEL_NAME%%_atom_update(), which can be called
> + * in tracepoints' handlers for example. In some specific cases
> where
> + * rv_%%MODEL_NAME%%_atom_update() is not convenient,
> rv_%%MODEL_NAME%%_atoms_fetch() can be used.
> + *
> + * rv_%%MODEL_NAME%%_init()/rv_%%MODEL_NAME%%_destroy() must be
> called while enabling/disabling
> + * the monitor.
> + *
> + * If the fields in struct ltl_monitor is not enough, extra custom
> data can be used. See
> + * rv_%%MODEL_NAME%%_get_data().
> + */
> +
> +#include <linux/sched.h>
> +
> +enum %%MODEL_NAME%%_atom {
> +%%ATOM_LIST%%
> +=09NUM_ATOM
> +};
> +
> +/**
> + * rv_%%MODEL_NAME%%_init
> + * @data_size:=09required custom data size, can be zero
> + *
> + * Must be called while enabling the monitor
> + */
> +int rv_%%MODEL_NAME%%_init(size_t data_size);
> +
> +/**
> + * rv_%%MODEL_NAME%%_destroy
> + *
> + * must be called while disabling the monitor
> + */
> +void rv_%%MODEL_NAME%%_destroy(void);
> +
> +/**
> + * rv_%%MODEL_NAME%%_error - report violation of the LTL property
> + * @task:=09the task violating the LTL property
> + * @mon:=09the LTL monitor
> + *
> + * Must be implemented. This function should invoke the RV reactor
> and the monitor's tracepoints.
> + */
> +void rv_%%MODEL_NAME%%_error(struct task_struct *task, struct
> ltl_monitor *mon);
> +
> +extern int rv_%%MODEL_NAME%%_task_slot;
> +
> +/**
> + * rv_%%MODEL_NAME%%_get_monitor - get the struct ltl_monitor of a
> task
> + */
> +static inline struct ltl_monitor
> *rv_%%MODEL_NAME%%_get_monitor(struct task_struct *task)
> +{
> +=09return &task->rv[rv_%%MODEL_NAME%%_task_slot].ltl_mon;
> +}
> +
> +/**
> + * rv_%%MODEL_NAME%%_atoms_init - initialize the atomic propositions
> + * @task:=09the task
> + * @mon:=09the LTL monitor
> + *
> + * Must be implemented. This function is called during task
> creation, and should initialize all
> + * atomic propositions. rv_%%MODEL_NAME%%_atom_set() should be used
> to implement this function.
> + *
> + * This function does not have to initialize atomic propositions
> that are updated by
> + * rv_%%MODEL_NAME%%_atoms_fetch(), because the two functions are
> called together.
> + */
> +void rv_%%MODEL_NAME%%_atoms_init(struct task_struct *task, struct
> ltl_monitor *mon);
> +
> +/**
> + * rv_%%MODEL_NAME%%_atoms_fetch - fetch the atomic propositions
> + * @task:=09the task
> + * @mon:=09the LTL monitor
> + *
> + * Must be implemented. This function is called anytime the Buchi
> automaton is triggered. Its
> + * intended purpose is to update the atomic propositions which are
> expensive to trace and can be
> + * easily read from @task. rv_%%MODEL_NAME%%_atom_set() should be
> used to implement this function.
> + *
> + * Using this function may cause incorrect verification result if it
> is important for the LTL that
> + * the atomic propositions must be updated at the correct time.
> Therefore, if it is possible,
> + * updating atomic propositions should be done with
> rv_%%MODEL_NAME%%_atom_update() instead.
> + *
> + * An example where this function is useful is with the LTL
> property:
> + *=C2=A0=C2=A0=C2=A0 always (RT imply not PAGEFAULT)
> + * (a realtime task does not raise page faults)
> + *
> + * In this example, adding tracepoints to track RT is complicated,
> because it is changed in
> + * differrent places (mutex's priority boosting,
> sched_setscheduler). Furthermore, for this LTL
> + * property, we don't care exactly when RT changes, as long as we
> have its correct value when
> + * PAGEFAULT=3D=3Dtrue. Therefore, it is better to update RT in
> rv_%%MODEL_NAME%%_atoms_fetch(), as it
> + * can easily be retrieved from task_struct.
> + *
> + * This function can be empty.
> + */
> +void rv_%%MODEL_NAME%%_atoms_fetch(struct task_struct *task, struct
> ltl_monitor *mon);
> +
> +/**
> + * rv_%%MODEL_NAME%%_atom_update - update an atomic proposition
> + * @task:=09the task
> + * @atom:=09the atomic proposition, one of enum
> %%MODEL_NAME%%_atom
> + * @value:=09the new value for @atom
> + *
> + * Update an atomic proposition and trigger the Buchi atomaton to
> check for violation of the LTL
> + * property. This function can be called in tracepoints' handler,
> for example.
> + */
> +void rv_%%MODEL_NAME%%_atom_update(struct task_struct *task,
> unsigned int atom, bool value);
> +
> +/**
> + * rv_%%MODEL_NAME%%_atom_get - get an atomic proposition
> + * @mon:=09the monitor
> + * @atom:=09the atomic proposition, one of enum
> %%MODEL_NAME%%_atom
> + *
> + * Returns the value of an atomic proposition.
> + */
> +static inline
> +enum ltl_truth_value rv_%%MODEL_NAME%%_atom_get(struct ltl_monitor
> *mon, unsigned int atom)
> +{
> +=09return mon->atoms[atom];
> +}
> +
> +/**
> + * rv_%%MODEL_NAME%%_atom_set - set an atomic proposition
> + * @mon:=09the monitor
> + * @atom:=09the atomic proposition, one of enum
> %%MODEL_NAME%%_atom
> + * @value:=09the new value for @atom
> + *
> + * Update an atomic proposition without triggering the Buchi
> automaton. This can be useful to
> + * implement rv_%%MODEL_NAME%%_atoms_fetch() and
> rv_%%MODEL_NAME%%_atoms_init().
> + *
> + * Another use case for this function is when multiple atomic
> propositions change at the same time,
> + * because calling rv_%%MODEL_NAME%%_atom_update() (and thus
> triggering the Buchi automaton)
> + * multiple times may be incorrect. In that case,
> rv_%%MODEL_NAME%%_atom_set() can be used to avoid
> + * triggering the Buchi automaton, and
> rv_%%MODEL_NAME%%_atom_update() is only used for the last
> + * atomic proposition.
> + */
> +static inline
> +void rv_%%MODEL_NAME%%_atom_set(struct ltl_monitor *mon, unsigned
> int atom, bool value)
> +{
> +=09mon->atoms[atom] =3D value;
> +}
> +
> +/**
> + * rv_%%MODEL_NAME%%_get_data - get the custom data of this monitor.
> + * @mon: the monitor
> + *
> + * If this function is used, rv_%%MODEL_NAME%%_init() must have been
> called with a positive
> + * data_size.
> + */
> +static inline void *rv_%%MODEL_NAME%%_get_data(struct ltl_monitor
> *mon)
> +{
> +=09return &mon->data;
> +}

Do we need all those functions defined here? We could have them
generated by the pre-processor just like with DA monitors.

Having a ltl_monitor.h defining all common utility functions and
variables (here I'm assuming most are, indeed, common) may save a lot
of maintenance.

Also I would rearrange monitors sources a bit differently, like putting
everything that doesn't need manual intervention (states and atoms
lists) in the header, remaining functions that may need tracepoint
wiring or more complex stuff can stay in a single c file, a bit like
current da monitors.

I see there seems to be more manual work in the main C file (e.g.
rtapp_block.c), but I think it would look cleaner if all other code was
generated by the preprocessor in a common header and all lists/inlined
functions created by the script stay in a separate header (why not call
it rtapp_block.h?).

What do you think?

Thanks,
Gabriele

