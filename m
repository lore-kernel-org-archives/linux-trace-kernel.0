Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B2C278E46
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Apr 2025 11:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744370259; cv=none; b=of+8D2WSvdLQ7OIljrFnYyIvtMZbV+YZScqHkgTJMW4axUvHx2XRpf0RX9HJwo4NX1Ni3SLJO6WEtNwHbXVA0ezuLxLjieeeeHPovlYTW9Ix6NUTVJExKkqyWZEnv9JLlmBtQmO9dJa3KNnNqQMrrbtOG1A2jAFYnNI4bTRsUj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744370259; c=relaxed/simple;
	bh=0ZGHdX9hfYNmXZczWjwRqyV5v5JuWGHMRjRLYmwQkmg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XOV071g0CSfcGfQ0HBmmDdjvYssQ9u+om5sr1w9U84ZGZfaM1KCa2qyPmZ9n36bjJZ9MfqT7A8mwOXiVJP2iXXExSjV9EVIt7QWXyrWSw1CD+9MiAVJNqMaFp0pMqpuG+o2YjhedYQvNzYHH6wUDrpQQiK8rde2NPFGv9s+bg18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dQk9jBPh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQk9jBPh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744370256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0ZGHdX9hfYNmXZczWjwRqyV5v5JuWGHMRjRLYmwQkmg=;
	b=dQk9jBPhNZoQYprqQET3NaRdcpLt2KDdZ92njPoZNO+I6iJ/iBIu79IpySPmC66V8JkxjL
	tVtVqxYn98FrN9EYCjXsxRjYWlciIK/aEOBDqgzdrday73fEN1hi8y7kUs2SJOUJoE0IZ7
	2063/PTCeK2W+ILGyOFC0HIX0zXYyqc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-iI8u0HmdP0mXoelxV5pg5A-1; Fri, 11 Apr 2025 07:17:35 -0400
X-MC-Unique: iI8u0HmdP0mXoelxV5pg5A-1
X-Mimecast-MFC-AGG-ID: iI8u0HmdP0mXoelxV5pg5A_1744370254
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d22c304adso13356365e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Apr 2025 04:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744370254; x=1744975054;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C0+uD6S7CtDdVRvvjRZyIcRhZZIa6u1wyyxqu9o0fxg=;
        b=LmtXFxRQlfnybTUR0i+h3YDUTp9JSxzPvmouPGDF3/g3VIxsj78V/3QgksCzVHdmZr
         g7P1deFERKecxXARPxHmDLX7e4LVk98iyXzy3t6INO8h75xJ9ql/CgbaxO4/lqKqDXG1
         udKdbwCdJUZ2ILI/kjXbqhZCp5bXdQzGrTAXy37OPjCOoh9chiYcltfWyMvv4qK+EaE8
         LbFzJtU0WUQYZVH1cyAqUJVZclcwUcpYcI4Am3YtMTriTmXD0R6z4ejHFqYSZWSyp3xv
         LJzaszuGCeu9u0VS6gRc2qM2PhQo5a8TBWsQ1M3HWzX0ZSQlWB9zTYjKDHD5DiyVfXbc
         6DSw==
X-Forwarded-Encrypted: i=1; AJvYcCVKnWTDhUD7b/uUa7cfxZm3NmM3riSXNMyPjbrdDfOuCHfpvgYZS/Ctftp/AxcvpY158HrTq7Vt29itnnXtyC78ZVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgD/bzhyNrdPBBsHUFCG2lvgIkdebpnCSlnoXPMSEZ7M8FfTDh
	+bDt2CwGcnIJ9ujymFPoUKhPEOu/AUppHb+UuK0II+amplz9PENr2fI8SiRjyy6i29PiAjjnUZ1
	XnUxADv4h9mretod8y8edhinExZuD1GgoFB7Mg3Chy+mdGEwlHd/gsiWGEpfoTOfQkIJ/oKTnMy
	EvpJUe
X-Gm-Gg: ASbGnctZ2r5Q2rOYvdIC6kr+Rt5pF2cBIFSmoyvKULv+j7oo51XSLPEZYpOm43M3Rfb
	FmOrq7EyJBCwV7n0LoOMAE5v2qXA+Z+PJHSIy04lBdiEm7bh0bbo9KUJDFFmhp845PHt6i+bcUV
	fRZjPrmaSJ2dKdduva9+I/A3pjuGPjaN29Xfz9U67TmxWe8WbWa9BODnqQNfpJ27xBNpD04Q7RZ
	yzhJI3z0O/q2ua7cZH6ujR1tqyTi3DHsn810xO18CDifPXeIYtqvCEM0QHmN5Xx+E0jI44T1mcW
	MqbadiZHuNxU6wGlz49EjBwZ7eZY212GLkK65Q==
X-Received: by 2002:a05:600c:c87:b0:43d:b33:679c with SMTP id 5b1f17b1804b1-43f39703f1cmr21202145e9.14.1744370253756;
        Fri, 11 Apr 2025 04:17:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEu5BZQg9v9iDNKZyWhCKsOKXFE0K3ALj/z3npJEc/xk124/mHTVBxfzJlwFTZ4POEuZDU3og==
X-Received: by 2002:a05:600c:c87:b0:43d:b33:679c with SMTP id 5b1f17b1804b1-43f39703f1cmr21201935e9.14.1744370253316;
        Fri, 11 Apr 2025 04:17:33 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f20626c19sm85983055e9.15.2025.04.11.04.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 04:17:32 -0700 (PDT)
Message-ID: <ce9ef5e41c17953010bd31d19e7d2840cd533066.camel@redhat.com>
Subject: Re: [PATCH v2 13/22] rv: Add support for LTL monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de
Date: Fri, 11 Apr 2025 13:17:30 +0200
In-Reply-To: <5dbd62940b252ee49777e9c4298eadd644bf6526.1744355018.git.namcao@linutronix.de>
References: <cover.1744355018.git.namcao@linutronix.de>
	 <5dbd62940b252ee49777e9c4298eadd644bf6526.1744355018.git.namcao@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: yu3ORKam9Pc5O8LIhRsAOBdQr_8Xi46dH-93MSBEqcM_1744370254
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-04-11 at 09:37 +0200, Nam Cao wrote:
> While attempting to implement DA monitors for some complex
> specifications,
> deterministic automaton is found to be inappropriate as the
> specification
> language. The automaton is complicated, hard to understand, and
> error-prone.
>=20
> For these cases, linear temporal logic is more suitable as the
> specification language.
>=20
> Add support for linear temporal logic runtime verification monitor.
>=20
> For all the details, see the documentations added by this commit.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> =C2=A0Documentation/trace/rv/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0.../trace/rv/linear_temporal_logic.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 97 +++
> =C2=A0Documentation/trace/rv/monitor_synthesis.rst=C2=A0 | 141 ++++-
> =C2=A0include/linux/rv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 56 +-
> =C2=A0include/rv/ltl_monitor.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 184 ++++++
> =C2=A0kernel/fork.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 5 +-
> =C2=A0kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +
> =C2=A0kernel/trace/rv/rv_trace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 47 ++
> =C2=A0tools/verification/rvgen/.gitignore=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
> =C2=A0tools/verification/rvgen/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0tools/verification/rvgen/__main__.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
> =C2=A0tools/verification/rvgen/rvgen/ltl2ba.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 552
> ++++++++++++++++++
> =C2=A0tools/verification/rvgen/rvgen/ltl2k.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 242 ++++++++
> =C2=A0.../verification/rvgen/templates/ltl2k/main.c | 102 ++++
> =C2=A0.../rvgen/templates/ltl2k/trace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 14 +
> =C2=A015 files changed, 1431 insertions(+), 25 deletions(-)
> =C2=A0create mode 100644 Documentation/trace/rv/linear_temporal_logic.rst
> =C2=A0create mode 100644 include/rv/ltl_monitor.h
> =C2=A0create mode 100644 tools/verification/rvgen/.gitignore
> =C2=A0create mode 100644 tools/verification/rvgen/rvgen/ltl2ba.py
> =C2=A0create mode 100644 tools/verification/rvgen/rvgen/ltl2k.py
> =C2=A0create mode 100644 tools/verification/rvgen/templates/ltl2k/main.c
> =C2=A0create mode 100644 tools/verification/rvgen/templates/ltl2k/trace.h
>=20
> diff --git a/Documentation/trace/rv/index.rst
> b/Documentation/trace/rv/index.rst
> index 8e411b76ec82..2a27f6bc9429 100644
> --- a/Documentation/trace/rv/index.rst
> +++ b/Documentation/trace/rv/index.rst
> ...
> =C2=A0
> diff --git a/include/linux/rv.h b/include/linux/rv.h
> index c7c18c06911b..c8320fa3a94b 100644
> --- a/include/linux/rv.h
> +++ b/include/linux/rv.h
> @@ -10,6 +10,10 @@
> =C2=A0#define MAX_DA_NAME_LEN=0932
> =C2=A0
> =C2=A0#ifdef CONFIG_RV
> +#include <linux/bitops.h>
> +#include <linux/types.h>
> +#include <linux/array_size.h>
> +
> =C2=A0/*
> =C2=A0 * Deterministic automaton per-object variables.
> =C2=A0 */
> @@ -18,6 +22,52 @@ struct da_monitor {
> =C2=A0=09unsigned int=09curr_state;
> =C2=A0};
> =C2=A0
> +/*
> + * In the future, if the number of atomic propositions or the size
> of Buchi automaton is larger, we
> + * can switch to dynamic allocation. For now, the code is simpler
> this way.
> + */
> +#define RV_MAX_LTL_ATOM 32
> +#define RV_MAX_BA_STATES 32
> +
> +/**
> + * struct ltl_monitor - A linear temporal logic runtime verification
> monitor
> + * @states:=09States in the Buchi automaton. As Buchi automaton is
> a
> + *=09=09non-deterministic state machine, the monitor can be
> in multiple states
> + *=09=09simultaneously. This is a bitmask of all possible
> states.
> + *=09=09If this is zero, that means either:
> + *=09=09=C2=A0=C2=A0=C2=A0 - The monitor has not started yet (e.g. becau=
se
> not all atomic propositions are
> + *=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 known).
> + *=09=09=C2=A0=C2=A0=C2=A0 - there is no possible state to be in. In oth=
er
> words, a violation of the
> + *=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LTL property is detected.
> + * @atoms:=09The values of atomic propositions.
> + * @unknown_atoms: Atomic propositions which are still unknown.
> + */
> +struct ltl_monitor {
> +#ifdef CONFIG_RV_LTL_MONITOR
> +=09DECLARE_BITMAP(states, RV_MAX_BA_STATES);
> +=09DECLARE_BITMAP(atoms, RV_MAX_LTL_ATOM);
> +=09DECLARE_BITMAP(unknown_atoms, RV_MAX_LTL_ATOM);
> +#endif
> +};

Mmh, we have a lot of those ifdefs in quite inappropriate places, but I
think we can do better than this.

What about something like:

#ifdef CONFIG_RV_LTL_MONITOR

struct ltl_monitor {
=09DECLARE_BITMAP(states, RV_MAX_BA_STATES);
=09DECLARE_BITMAP(atoms, RV_MAX_LTL_ATOM);
=09DECLARE_BITMAP(unknown_atoms, RV_MAX_LTL_ATOM);
};

static inline bool rv_ltl_valid_state(struct ltl_monitor *mon)
{
=09...
}

static inline bool rv_ltl_all_atoms_known(struct ltl_monitor *mon)
{
=09...
}

#else

/*
 * Leave the struct empty not to use up space
 * In a later patch we could do the same for DAs..
 */
struct ltl_monitor { };

#endif

> +
> +static inline bool rv_ltl_valid_state(struct ltl_monitor *mon)
> +{
> +=09for (int i =3D 0; i < ARRAY_SIZE(mon->states); ++i) {
> +=09=09if (mon->states[i])
> +=09=09=09return true;
> +=09}
> +=09return false;
> +}
> +
> +static inline bool rv_ltl_all_atoms_known(struct ltl_monitor *mon)
> +{
> +=09for (int i =3D 0; i < ARRAY_SIZE(mon->unknown_atoms); ++i) {
> +=09=09if (mon->unknown_atoms[i])
> +=09=09=09return false;
> +=09}
> +=09return true;
> +}
> +
> =C2=A0/*
> =C2=A0 * Per-task RV monitors count. Nowadays fixed in
> RV_PER_TASK_MONITORS.
> =C2=A0 * If we find justification for more monitors, we can think about
> @@ -27,11 +77,9 @@ struct da_monitor {
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
> =C2=A0
> =C2=A0#ifdef CONFIG_RV_REACTORS
> diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
> new file mode 100644
> index 000000000000..78f5a1197665
> --- /dev/null
> +++ b/include/rv/ltl_monitor.h

You hate macros don't you? :)
Anyway I really like your approach, very neat.

> @@ -0,0 +1,184 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/**
> + * This file must be combined with the $(MODEL_NAME).h file
> generated by
> + * tools/verification/rvgen.
> + */
> +
> +#include <linux/args.h>
> +#include <linux/rv.h>
> +#include <linux/stringify.h>
> +#include <linux/seq_buf.h>
> +#include <rv/instrumentation.h>
> +#include <trace/events/task.h>
> +#include <trace/events/sched.h>
> +
> +#ifndef MONITOR_NAME
> +#error "MONITOR_NAME macro is not defined. Did you include
> $(MODEL_NAME).h generated by rvgen?"
> +#endif
> +
> +#ifdef CONFIG_RV_REACTORS
> +#define RV_MONITOR_NAME CONCATENATE(rv_, MONITOR_NAME)
> +static struct rv_monitor RV_MONITOR_NAME;
> +
> +static void rv_cond_react(struct task_struct *task)
> +{
> +=09if (!rv_reacting_on() || !RV_MONITOR_NAME.react)
> +=09=09return;
> +=09RV_MONITOR_NAME.react("rv: "__stringify(MONITOR_NAME)":
> %s[%d]: violation detected\n",
> +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 task->comm, task->pid);
> +}
> +#else
> +static void rv_cond_react(struct task_struct *task)
> +{
> +}
> +#endif
> +
> +static int ltl_monitor_slot =3D RV_PER_TASK_MONITOR_INIT;
> +
> +static void ltl_atoms_fetch(struct task_struct *task, struct
> ltl_monitor *mon);
> +static void ltl_atoms_init(struct task_struct *task, struct
> ltl_monitor *mon, bool task_creation);
> +
> +static struct ltl_monitor *ltl_get_monitor(struct task_struct *task)
> +{
> +=09return &task->rv[ltl_monitor_slot].ltl_mon;
> +}

This means ltl monitors only support per-task, right?
It shouldn't take much effort putting an ifdef chain here and defining e.g.
PER_CPU in the header file to choose a different get_monitor.
Or directly an ltl_monitor_implicit.h

I think this patch is ready without it, just trying to brainstorm how we co=
uld
potentially extend this.

I need more time to play with these, but it looks promising.

Thanks,
Gabriele

