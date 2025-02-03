Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4733A3597F
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Feb 2025 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738566906; cv=none; b=XZ8RvvGVBL6ysnkzP9Wwycc0is/s9ieI9xGx0ezVNBgvj3YSTea+ZCMdju0GiJo0IPli/R62IUbzDtP/q9o4Z/voJ9XciEw+ouHykGub85Rsw86hj6I3rg1v/YoWT3NtAGaREFnEBFln9/9sHS9NmrrqkJrWGdqc3E5B2D+VfoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738566906; c=relaxed/simple;
	bh=J9cg3VbzMKdhl7yy9rwRIS9tCFCmPGy+hSm0MhWtihg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b7ceMd49KM7+OIe1mZ8Uby/BJpGo8E60poYVsw/Hrcz2leCCRhM4EdF4lhHrEv24vf+6Xci2xvgQuWFs5Kgnh3FVUZ7UgjN02kXKCyfkTUt7sfySvREedUUaUwq+3MStUvm+51eFMzOoMA7r2KnRKst0nK93mSiEvJza6JwqtEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kr6pNFIM; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kr6pNFIM"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aafc9d75f8bso815718266b.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 02 Feb 2025 23:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738566902; x=1739171702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4Q2C26T0K74YYtpMKkiUgCp9WgkXow2PCxFIgsZpR8=;
        b=kr6pNFIM72999ZxddZ91SyKGn2TVz3mVhYwWNSHZ+cvCUklq+8lFQdunZA47ndo80/
         CtQCrxW2cGvBMW5D2RyEmFy47lwm0RN5DxHdGGxIQ+fbgi3OZmlT9c555lJ1aXgi89Ib
         5Enw29XR5ojgLS6+EiJdir5pytrIp7QDmhpLKpO0CxTuDNiBTenJBDg+/Uc1kTWpHV8O
         v79JRr3LT9VFJnQgxBLr5kdXJa3n6vHG27K3Vid7by9aqVDEdYgeybtE2gqbJLegQzEP
         7qK+Iqwpddaf9SxE1tEFiX5hxOTfS7xRIeP3jDXTXRAlq+EVZonBvlzMSl++jTFHh1K2
         HPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738566902; x=1739171702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4Q2C26T0K74YYtpMKkiUgCp9WgkXow2PCxFIgsZpR8=;
        b=LTjNv8vOeEgf+VZrGC/wpj0bgZCF/tiWZ4zR3nGl9FOtV/EJnlOxNR1+25eQbP/XQG
         iylYRIAUHeyCElx1yDsuvmGJsB+Y2K/B3+wWLoObgT+o2Bq2HfDpAMRG3Lv+vJG2c95z
         xh8TcGe0I3QAEnT2fpF8ljPZLRranz6OOGFfUrqCLULA3WeyJOSqH5hcPgK3XR+ndIu7
         fxPTiJgFso+iCfaLLm3Z0aRT/utXOV6B0vx+7rhgh4S34dLIcCKVFn4la6I1+mVT4kgk
         xKqL+jBv76tH9DDKIZu/Ae9s+B96LWpleCxoUxmlkEjXu1wm0WafzzloXqE2b/q6w0/Z
         yG1A==
X-Forwarded-Encrypted: i=1; AJvYcCWpfZVSZjBpGaDsJvQ26EpwBiTdRrE7oYqRQ9abTkqt7GrZVxxxjzrCi8Z2Nur6CoxrtDC0cPH4yc68Blyow+55f1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJgqjZY1VgdmWAkXnBuAL3oIejWdbp71xmC+Ofx6DligVKt3N/
	L3lMtHggy6QiQTBYfKD4nsbf+JNKby1YPxcz6lwWudhWkoyAyooTkiLBlGv3VW4ZtKyzpZp8N/x
	KwNEfZnPb7qWh1hOmh5okiU9iQ56O9vIR1wEC
X-Gm-Gg: ASbGncvJfU5V+S4842bd66kf2+K5/bgRNKkaCqBiG1Wr9tMXJZC0kNS+dXXeRNiFjrm
	5YW6jILSeaXHjcLhABiON99s5Ssz23c5fGKrGTUR0KgBMoJKDwLzhzqm6hf2AHKwtwmsR9gwsHS
	2ny4D9GRWr3Y+XJH0Tnn0tvUKyJMyo
X-Google-Smtp-Source: AGHT+IHdYYosvgmkyk0C8oZShVymubMByyKMeQ8cwNm/+8aabmGSqYwd9mo6bUikqVJ6ovwhEY68gP7+kn4UIYDAqqs=
X-Received: by 2002:a17:907:7ba3:b0:ab6:8bc1:9b5a with SMTP id
 a640c23a62f3a-ab6cfda42bbmr2465753066b.41.1738566900382; Sun, 02 Feb 2025
 23:15:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250130100050.1868208-1-kirill.shutemov@linux.intel.com>
 <20250130100050.1868208-7-kirill.shutemov@linux.intel.com> <CAMgjq7AWZg0Y7+v3_Z8-YVUXrANB29mCDSyzF39dtAM_TQ0aKw@mail.gmail.com>
In-Reply-To: <CAMgjq7AWZg0Y7+v3_Z8-YVUXrANB29mCDSyzF39dtAM_TQ0aKw@mail.gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 3 Feb 2025 00:14:23 -0700
X-Gm-Features: AWEUYZl7Aut54vM8LMQf8gmofutWUertOFMuqNs0Wcb_mrIfZVJF6RYYAJtQ1BU
Message-ID: <CAOUHufa6gVygmgscgrtX63Z9iE=EL9-tL-YGk7omSHhZhkj64w@mail.gmail.com>
Subject: Re: [PATCHv3 06/11] mm/vmscan: Use PG_dropbehind instead of PG_reclaim
To: Kairui Song <ryncsn@gmail.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Andi Shyti <andi.shyti@linux.intel.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Christian Brauner <brauner@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dan Carpenter <dan.carpenter@linaro.org>, 
	David Airlie <airlied@gmail.com>, David Hildenbrand <david@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Josef Bacik <josef@toxicpanda.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Nhat Pham <nphamcs@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Ran Xiaokai <ran.xiaokai@zte.com.cn>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>, 
	Steven Rostedt <rostedt@goodmis.org>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	Vlastimil Babka <vbabka@suse.cz>, Yosry Ahmed <yosryahmed@google.com>, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 1, 2025 at 1:02=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> On Thu, Jan 30, 2025 at 6:02=E2=80=AFPM Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > The recently introduced PG_dropbehind allows for freeing folios
> > immediately after writeback. Unlike PG_reclaim, it does not need vmscan
> > to be involved to get the folio freed.
> >
> > Instead of using folio_set_reclaim(), use folio_set_dropbehind() in
> > pageout().
> >
> > It is safe to leave PG_dropbehind on the folio if, for some reason
> > (bug?), the folio is not in a writeback state after ->writepage().
> > In these cases, the kernel had to clear PG_reclaim as it shared a page
> > flag bit with PG_readahead.
> >
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > ---
> >  mm/vmscan.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index bc1826020159..c97adb0fdaa4 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -692,19 +692,16 @@ static pageout_t pageout(struct folio *folio, str=
uct address_space *mapping,
> >                 if (shmem_mapping(mapping) && folio_test_large(folio))
> >                         wbc.list =3D folio_list;
> >
> > -               folio_set_reclaim(folio);
> > +               folio_set_dropbehind(folio);
> > +
> >                 res =3D mapping->a_ops->writepage(&folio->page, &wbc);
> >                 if (res < 0)
> >                         handle_write_error(mapping, folio, res);
> >                 if (res =3D=3D AOP_WRITEPAGE_ACTIVATE) {
> > -                       folio_clear_reclaim(folio);
> > +                       folio_clear_dropbehind(folio);
> >                         return PAGE_ACTIVATE;
> >                 }
> >
> > -               if (!folio_test_writeback(folio)) {
> > -                       /* synchronous write or broken a_ops? */
> > -                       folio_clear_reclaim(folio);
> > -               }
> >                 trace_mm_vmscan_write_folio(folio);
> >                 node_stat_add_folio(folio, NR_VMSCAN_WRITE);
> >                 return PAGE_SUCCESS;
> > --
> > 2.47.2
> >
>
> Hi, I'm seeing following panic with SWAP after this commit:
>
> [   29.672319] Oops: general protection fault, probably for
> non-canonical address 0xffff88909a3be3: 0000 [#1] PREEMPT SMP NOPTI
> [   29.675503] CPU: 82 UID: 0 PID: 5145 Comm: tar Kdump: loaded Not
> tainted 6.13.0.ptch-g1fe9ea48ec98 #917
> [   29.677508] Hardware name: Red Hat KVM/RHEL-AV, BIOS 0.0.0 02/06/2015
> [   29.678886] RIP: 0010:__lock_acquire+0x20/0x15d0
> [   29.679891] Code: 90 90 90 90 90 90 90 90 90 90 41 57 41 56 41 55
> 41 54 55 53 48 83 ec 30 8b 2d 10 ac f3 01 44 8b ac 24 88 00 00 00 85
> ed 74 64 <48> 8b 07 49 89 ff 48 3d 20 1d bf 83 74 56 8b 1d 8c f5 b1 01
> 41 89
> [   29.683852] RSP: 0018:ffffc9000bea3148 EFLAGS: 00010002
> [   29.684980] RAX: ffff8890874b2940 RBX: 0000000000000200 RCX: 000000000=
0000000
> [   29.686510] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00ffff889=
09a3be3
> [   29.688031] RBP: 0000000000000001 R08: 0000000000000001 R09: 000000000=
0000000
> [   29.689561] R10: 0000000000000000 R11: 0000000000000020 R12: 00ffff889=
09a3be3
> [   29.691087] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000=
0000000
> [   29.692613] FS:  00007fa05c2824c0(0000) GS:ffff88a03fa80000(0000)
> knlGS:0000000000000000
> [   29.694339] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   29.695581] CR2: 000055f9abb7fc7d CR3: 00000010932f2002 CR4: 000000000=
0770eb0
> [   29.697109] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [   29.698637] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [   29.700161] PKRU: 55555554
> [   29.700759] Call Trace:
> [   29.701296]  <TASK>
> [   29.701770]  ? __die_body+0x1e/0x60
> [   29.702540]  ? die_addr+0x3c/0x60
> [   29.703267]  ? exc_general_protection+0x18f/0x3c0
> [   29.704290]  ? asm_exc_general_protection+0x26/0x30
> [   29.705345]  ? __lock_acquire+0x20/0x15d0
> [   29.706215]  ? lockdep_hardirqs_on_prepare+0xda/0x190
> [   29.707304]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [   29.708452]  lock_acquire+0xbf/0x2e0
> [   29.709229]  ? folio_unmap_invalidate+0x12f/0x220
> [   29.710257]  ? __folio_end_writeback+0x15d/0x430
> [   29.711260]  ? __folio_end_writeback+0x116/0x430
> [   29.712261]  _raw_spin_lock+0x30/0x40
> [   29.713064]  ? folio_unmap_invalidate+0x12f/0x220
> [   29.714076]  folio_unmap_invalidate+0x12f/0x220
> [   29.715058]  folio_end_writeback+0xdf/0x190
> [   29.715967]  swap_writepage_bdev_sync+0x1e0/0x450
> [   29.716994]  ? __pfx_submit_bio_wait_endio+0x10/0x10
> [   29.718074]  swap_writepage+0x46b/0x6b0
> [   29.718917]  pageout+0x14b/0x360
> [   29.719628]  shrink_folio_list+0x67d/0xec0
> [   29.720519]  ? mark_held_locks+0x48/0x80
> [   29.721375]  evict_folios+0x2a7/0x9e0
> [   29.722179]  try_to_shrink_lruvec+0x19a/0x270
> [   29.723130]  lru_gen_shrink_lruvec+0x70/0xc0
> [   29.724060]  ? __lock_acquire+0x558/0x15d0
> [   29.724954]  shrink_lruvec+0x57/0x780
> [   29.725754]  ? find_held_lock+0x2d/0xa0
> [   29.726588]  ? rcu_read_unlock+0x17/0x60
> [   29.727449]  shrink_node+0x2ad/0x930
> [   29.728229]  do_try_to_free_pages+0xbd/0x4e0
> [   29.729160]  try_to_free_mem_cgroup_pages+0x123/0x2c0
> [   29.730252]  try_charge_memcg+0x222/0x660
> [   29.731128]  charge_memcg+0x3c/0x80
> [   29.731888]  __mem_cgroup_charge+0x30/0x70
> [   29.732776]  shmem_alloc_and_add_folio+0x1a5/0x480
> [   29.733818]  ? filemap_get_entry+0x155/0x390
> [   29.734748]  shmem_get_folio_gfp+0x28c/0x6c0
> [   29.735680]  shmem_write_begin+0x5a/0xc0
> [   29.736535]  generic_perform_write+0x12a/0x2e0
> [   29.737503]  shmem_file_write_iter+0x86/0x90
> [   29.738428]  vfs_write+0x364/0x530
> [   29.739180]  ksys_write+0x6c/0xe0
> [   29.739906]  do_syscall_64+0x66/0x140
> [   29.740713]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   29.741800] RIP: 0033:0x7fa05c439984
> [   29.742584] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f
> 84 00 00 00 00 00 f3 0f 1e fa 80 3d c5 06 0e 00 00 74 13 b8 01 00 00
> 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20
> 48 89
> [   29.746542] RSP: 002b:00007ffece7720f8 EFLAGS: 00000202 ORIG_RAX:
> 0000000000000001
> [   29.748157] RAX: ffffffffffffffda RBX: 0000000000002800 RCX: 00007fa05=
c439984
> [   29.749682] RDX: 0000000000002800 RSI: 000055f9cfa08000 RDI: 000000000=
0000004
> [   29.751216] RBP: 00007ffece772140 R08: 0000000000002800 R09: 000000000=
0000007
> [   29.752743] R10: 0000000000000180 R11: 0000000000000202 R12: 000055f9c=
fa08000
> [   29.754262] R13: 0000000000000004 R14: 0000000000002800 R15: 000000000=
00009af
> [   29.755797]  </TASK>
> [   29.756285] Modules linked in: zram virtiofs
>
> I'm testing with PROVE_LOCKING on. It seems folio_unmap_invalidate is
> called for swapcache folio and it doesn't work well, following PATCH
> on top of mm-unstable seems fix it well:

I think there is a bigger problem here. folio_end_reclaim_write()
currently calls folio_unmap_invalidate() to remove the mapping, and
that's very different from what __remove_mapping() does in the reclaim
path: not only it breaks the swapcache case, the shadow entry is also
lost.
