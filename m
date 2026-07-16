Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BDB3DB62F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Jul 2026 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784209826; cv=none; b=R5/nUFEpZadzlDj2YH9X7BVc2aL1pxKx78SpeHsmL0m5mQ/73GraFvxDG+GMj2CY3Bc00XgQkN3trGTQ/Ot/mWBZG7wtn4tXQoEy5fbJnynN90mj4xJhUZDe9CUyN5vXkd+engQmfiBpTjYRYAEzo6V77pntwT0wPcbQm7lQfZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784209826; c=relaxed/simple;
	bh=bEsLuEOlnMdGHX8mkivW5e6Px8kjjtF7V+GXA8wXj7o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ieSoENF5O8jfhMD49fjaPx6aIWkAGCtwm6LwXP1OtnHFIqkkv0oGzgzjqgHnqS3SaqqKbE6Y7QsRK0152X8UCu9FkqcYgYRiegYA1fRGf9pWXV9M7tth1U8NBuRs7gNoakG9CVuv4mPKQtSQqD5B+M5J4WDQ+2urEiK6u9zt/oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HbtqJsDq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HbtqJsDq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784209823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bEsLuEOlnMdGHX8mkivW5e6Px8kjjtF7V+GXA8wXj7o=;
	b=HbtqJsDqFApcB6fAIAqLGhnI2+8ihBr6OVlBJFSRA45xvwWZdGUJFm3k/Y++hl1CRjBKKO
	0khFVL/Ujgh9bQq0E2BqoGunwLAWmTsMnMzpQrexpYumPUpsdRbxxyIa9CDMc74sXfwaYg
	Zed8FE5tugd6LZDhpTWs8WbkGc0Ic0c=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-p4dkfCAbN625ylbExxhGvQ-1; Thu, 16 Jul 2026 09:50:22 -0400
X-MC-Unique: p4dkfCAbN625ylbExxhGvQ-1
X-Mimecast-MFC-AGG-ID: p4dkfCAbN625ylbExxhGvQ_1784209820
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-698ac6f2461so7515791a12.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Jul 2026 06:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784209820; x=1784814620;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=67Gm5PocQdlRFd5TX7tAjWlVgcuxtlTA0Eh397YmwuI=;
        b=T/nW46Oar/yokjCOvBDttsQvowjhPhxuztRVC46NFXOs5x5JqaxQ4UHlac7oxSik18
         K6Sst2w7M2ImWHZ1hOA+HQJOwXH/gO5gyp0FoRerBzYk/TXU0MyxhaPuVGIsr5/LOI6y
         2oPi0eMHSFUuV3ty1fNybdL5P/E3KRSfGYYRFsAM+bcb5Q0lrobJ8eHYD1cVsuNFKMhB
         LhJ9ItDN9kYRyjECvJ+pQknYXG20orjtl4Q3p0aF+ffICawGRmo89mcku63Eu71aOTMF
         lZrmAHeVJPQ0ryuJjSC2ZoJk+84Lr1jEWQ+Tm/3aDYlA/8fz6J9W3rn9nfTX1UFUI2wn
         zDzA==
X-Forwarded-Encrypted: i=1; AHgh+RolPN2/sqUmrDaQtNsDfsDhFrrdtFaQtA+6x/encV1cH3BRqskSgMfgbwI2g8rWW/JlGJZz7GzByQntBViiwMuPsDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsBqLlWXSQK1JpP9O+FZvIZ1Gash8O7K9LmDUltS7RrjdqFUQd
	RvSFh2lNn+SFreOxkwF7F9WlZaSDLV5qsZygG1JzsQa4QvLJy1LSD1v2Flyyu8b/gwyspWmlwKM
	tBdIzSnIzoXrFlJDkTOIJAeuUfzB1k0bBRYFzlnzh7DR5SANz0LOF6VjDMI5at8viuSvUcRCqWQ
	==
X-Gm-Gg: AfdE7ckA95m4qZSQTX3ZF6EOPrfj/QDZqI1JjLM6DcR8k1HSALZEzN79ikRbUBN4bAq
	NLZWXb4lEMMXfu8b3+ag9KHMAoq/p2wPCcC7z3qi4So/1rDMGor7f/t0jpzNa+yYmNb0vyW/ZK3
	xdakL9Uk/ARHO+nOJbuafOAbmIVZE/3ivk8yABh5TaPzNQp6CzKVQyTFB0QbTQzUHvVJsIbL2sZ
	h7biBmEPhvs5EUBD+Rz/mQK12+zDrAu1U0x7UI/vbmf+dLTNKYu4W5T9ann9OuwUkRSEOEUwN5H
	iqx71TEaDAkaHo3iabOAX4w+ooedmh8pKZE2uNmVEmMbSqowMSQxUW90eu054x0XE+dGiLEddR5
	vlPHi9FJCxXpoYq2CKrlSmU2N3kWl87UrKEYhGXiI2FwKImEeHP+/O6n//L5YDQuar33w4g==
X-Received: by 2002:a05:6402:42cb:b0:69c:7406:9492 with SMTP id 4fb4d7f45d1cf-69cd6ddb660mr6244200a12.39.1784209820066;
        Thu, 16 Jul 2026 06:50:20 -0700 (PDT)
X-Received: by 2002:a05:6402:42cb:b0:69c:7406:9492 with SMTP id 4fb4d7f45d1cf-69cd6ddb660mr6244175a12.39.1784209819600;
        Thu, 16 Jul 2026 06:50:19 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69cd293bb8bsm4731784a12.22.2026.07.16.06.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 06:50:19 -0700 (PDT)
Message-ID: <2d5915906df646c206b425ef326fd54fd7250a8f.camel@redhat.com>
Subject: Re: [PATCH 1/2] rv/nomiss: fix task storage lifetime
From: Gabriele Monaco <gmonaco@redhat.com>
To: Li Qiang <liqiang01@kylinos.cn>, linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, namcao@linutronix.de,
 juri.lelli@redhat.com, 	wen.yang@linux.dev
Date: Thu, 16 Jul 2026 15:50:17 +0200
In-Reply-To: <20260715060023.1502983-1-liqiang01@kylinos.cn>
References: <20260715060023.1502983-1-liqiang01@kylinos.cn>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cjkjJhe83T0cZ-k_On8oRodVRnqTRxkBd-ZfOOLie4E_1784209820
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-15 at 14:00 +0800, Li Qiang wrote:
> The nomiss monitor stores a pointer to a task's embedded deadline entity
> in per-PID object storage. The exit handler only removed that storage whe=
n
> the task was still SCHED_DEADLINE. A task that changed to another policy
> before exiting left its entry behind. Once the PID was reused, the new ta=
sk
> could reuse the old entry and dereference the freed deadline entity.

Yes, this is actually an issue, but wouldn't it be solved by just deleting =
the
storage as soon as a task changes its policy out of DEADLINE ?

We are currently only resetting the monitor (so timers won't fire), but del=
eting
would probably be more appropriate.

Then there's the issue we are tracking the syscall entry, so we don't know =
if
that is going to succeed, a more robust solution would be to add a tracepoi=
nt
inside the actual __sched_setscheduler() (but maintainers may not want that=
) or
tracking the context (old policy) inside sys_enter and commit the result in
sys_exit only if it succeeds.

> Remove storage unconditionally at sched_process_exit. Serialize creation
> and destruction with locks sharded by PID, and do not create storage once
> PF_EXITING is set. Each shard tracks both stored entries and in-flight
> creators, allowing exits for shards without storage to avoid locking and
> hash lookups while preserving the create/exit ordering.

I don't get why we need this complex machinery. What races are you trying t=
o
solve with this locks? Concurrent syscalls and newtask/exit can this even
happen?

Thanks,
Gabriele

>=20
> Fixes: b133207deb72 ("rv: Add nomiss deadline monitor")
> Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
> ---
> =C2=A0kernel/trace/rv/monitors/deadline/deadline.h | 86 +++++++++++++++++=
++-
> =C2=A0kernel/trace/rv/monitors/nomiss/nomiss.c=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 2 +-
> =C2=A02 files changed, 84 insertions(+), 4 deletions(-)
>=20
> diff --git a/kernel/trace/rv/monitors/deadline/deadline.h
> b/kernel/trace/rv/monitors/deadline/deadline.h
> index 78fca873d61e..b92480e79807 100644
> --- a/kernel/trace/rv/monitors/deadline/deadline.h
> +++ b/kernel/trace/rv/monitors/deadline/deadline.h
> @@ -1,6 +1,8 @@
> =C2=A0/* SPDX-License-Identifier: GPL-2.0 */
> =C2=A0
> =C2=A0#include <linux/kernel.h>
> +#include <linux/hash.h>
> +#include <linux/spinlock.h>
> =C2=A0#include <linux/uaccess.h>
> =C2=A0#include <linux/sched/deadline.h>
> =C2=A0#include <asm/syscall.h>
> @@ -148,6 +150,37 @@ static inline struct sched_dl_entity *get_server(str=
uct
> task_struct *tsk, u8 typ
> =C2=A0=09return NULL;
> =C2=A0}
> =C2=A0
> +#define DEADLINE_STORAGE_LOCK_BITS=096
> +#define DEADLINE_STORAGE_LOCKS=09=09BIT(DEADLINE_STORAGE_LOCK_BITS)
> +
> +/*
> + * A shard tracks both entries and creators which have not yet checked
> + * PF_EXITING. This lets unrelated exits avoid taking a storage lock whi=
le
> + * preserving the create/exit ordering.
> + */
> +struct deadline_storage_shard {
> +=09raw_spinlock_t lock;
> +=09atomic_t users;
> +} ____cacheline_aligned_in_smp;
> +
> +static struct deadline_storage_shard
> +=09deadline_storage_shards[DEADLINE_STORAGE_LOCKS];
> +
> +static inline struct deadline_storage_shard *deadline_storage_shard(int =
pid)
> +{
> +=09return &deadline_storage_shards[hash_32(pid,
> DEADLINE_STORAGE_LOCK_BITS)];
> +}
> +
> +static void deadline_storage_init(void)
> +{
> +=09int i;
> +
> +=09for (i =3D 0; i < DEADLINE_STORAGE_LOCKS; i++) {
> +=09=09raw_spin_lock_init(&deadline_storage_shards[i].lock);
> +=09=09atomic_set(&deadline_storage_shards[i].users, 0);
> +=09}
> +}
> +
> =C2=A0/*
> =C2=A0 * Initialise monitors for all tasks and pre-allocate the storage f=
or
> servers.
> =C2=A0 * This is necessary since we don't have access to the servers here=
 and
> @@ -159,6 +192,8 @@ static inline int init_storage(bool skip_tasks)
> =C2=A0=09struct task_struct *g, *p;
> =C2=A0=09int cpu;
> =C2=A0
> +=09deadline_storage_init();
> +
> =C2=A0=09for_each_possible_cpu(cpu) {
> =C2=A0=09=09if (!da_create_empty_storage(fair_server_id(cpu)))
> =C2=A0=09=09=09goto fail;
> @@ -177,6 +212,7 @@ static inline int init_storage(bool skip_tasks)
> =C2=A0=09=09=09=09read_unlock(&tasklist_lock);
> =C2=A0=09=09=09=09goto fail;
> =C2=A0=09=09=09}
> +=09=09=09atomic_inc(&deadline_storage_shard(p->pid)->users);
> =C2=A0=09=09}
> =C2=A0=09}
> =C2=A0=09read_unlock(&tasklist_lock);
> @@ -187,17 +223,61 @@ static inline int init_storage(bool skip_tasks)
> =C2=A0=09return -ENOMEM;
> =C2=A0}
> =C2=A0
> +static void deadline_create_task_storage(struct task_struct *task)
> +{
> +=09struct deadline_storage_shard *shard =3D deadline_storage_shard(task-
> >pid);
> +=09bool created =3D false;
> +
> +=09/*
> +=09 * The temporary reference makes an in-flight creator visible to
> exit.
> +=09 * If storage is created, it becomes the reference owned by that
> entry.
> +=09 */
> +=09atomic_inc(&shard->users);
> +=09/* Pair with exit before it tests users without taking the shard
> lock. */
> +=09smp_mb__after_atomic();
> +
> +=09raw_spin_lock(&shard->lock);
> +=09if (!(READ_ONCE(task->flags) & PF_EXITING)) {
> +=09=09guard(rcu)();
> +=09=09if (!da_get_monitor(EXPAND_ID_TASK(task)) &&
> +=09=09=C2=A0=C2=A0=C2=A0 da_create_storage(EXPAND_ID_TASK(task), NULL))
> +=09=09=09created =3D true;
> +=09}
> +=09raw_spin_unlock(&shard->lock);
> +
> +=09if (!created)
> +=09=09atomic_dec(&shard->users);
> +}
> +
> +static void deadline_destroy_task_storage(struct task_struct *task)
> +{
> +=09struct deadline_storage_shard *shard =3D deadline_storage_shard(task-
> >pid);
> +
> +=09/* Pair with the creator barrier before taking the no-storage fast
> path. */
> +=09smp_mb();
> +=09if (!atomic_read(&shard->users))
> +=09=09return;
> +
> +=09raw_spin_lock(&shard->lock);
> +=09guard(rcu)();
> +=09if (da_get_monitor(task->pid, NULL)) {
> +=09=09/* A task may leave SCHED_DEADLINE before exiting. */
> +=09=09da_destroy_storage(task->pid);
> +=09=09atomic_dec(&shard->users);
> +=09}
> +=09raw_spin_unlock(&shard->lock);
> +}
> +
> =C2=A0static void __maybe_unused handle_newtask(void *data, struct task_s=
truct
> *task, u64 flags)
> =C2=A0{
> =C2=A0=09/* Might be superfluous as tasks are not started with this polic=
y..
> */
> =C2=A0=09if (task->policy =3D=3D SCHED_DEADLINE)
> -=09=09da_create_storage(EXPAND_ID_TASK(task), NULL);
> +=09=09deadline_create_task_storage(task);
> =C2=A0}
> =C2=A0
> =C2=A0static void __maybe_unused handle_exit(void *data, struct task_stru=
ct *p,
> bool group_dead)
> =C2=A0{
> -=09if (p->policy =3D=3D SCHED_DEADLINE)
> -=09=09da_destroy_storage(get_entity_id(&p->dl, DL_TASK, DL_TASK));
> +=09deadline_destroy_task_storage(p);
> =C2=A0}
> =C2=A0
> =C2=A0#endif
> diff --git a/kernel/trace/rv/monitors/nomiss/nomiss.c
> b/kernel/trace/rv/monitors/nomiss/nomiss.c
> index 8ead8783c29f..2e5ee681505b 100644
> --- a/kernel/trace/rv/monitors/nomiss/nomiss.c
> +++ b/kernel/trace/rv/monitors/nomiss/nomiss.c
> @@ -214,7 +214,7 @@ static void handle_sys_enter(void *data, struct pt_re=
gs
> *regs, long id)
> =C2=A0=09if (p->policy =3D=3D SCHED_DEADLINE)
> =C2=A0=09=09da_reset(EXPAND_ID_TASK(p));
> =C2=A0=09else if (new_policy =3D=3D SCHED_DEADLINE)
> -=09=09da_create_or_get(EXPAND_ID_TASK(p));
> +=09=09deadline_create_task_storage(p);
> =C2=A0}
> =C2=A0
> =C2=A0static void handle_sched_wakeup(void *data, struct task_struct *tsk=
)

