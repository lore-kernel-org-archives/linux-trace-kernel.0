Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AFDDF42
	for <linux-trace-kernel@vger.kernel.org>; Sat, 23 Sep 2023 15:26:15 +0000 (UTC)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD59F193
	for <linux-trace-kernel@vger.kernel.org>; Sat, 23 Sep 2023 08:26:13 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d8181087dc9so4185645276.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 23 Sep 2023 08:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695482773; x=1696087573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+h/az42itE2oKI662KLx1KdcIMxc2RkjNaC45gpe54=;
        b=SNbNDfideU2foFDKGHypkjE2hiZ6Xv5iKihRY6zYc3Iv9qUCBLCxX32KiYNNWROfhm
         CrNi5xhbVrQYShQINwfT7rI+JxDww/Z1BZWzw0elnh58n87O27xpa1QEm6bqrP+cofxp
         64OW2BXgcmrenB8VEpX662y9N9HFLrmpoHRiv71rrZmJNmZbJh4bO3h07B465GIANfGT
         k2kijed2udFAi7XZ8KhtryCin71UyevQpgZ9vvCSZYrscV+ioaHckjJ+W/New/vhUGts
         c5Bf+l2b1U5o5VVQXcB5ygEWnJj1zI3tMPlUDJIevQBDE7f0NymIQZsay8ZYEiaNkEXw
         Q24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695482773; x=1696087573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+h/az42itE2oKI662KLx1KdcIMxc2RkjNaC45gpe54=;
        b=J//Er9uOLBLSjKhByo/OhuU6TtAm9kZMf90H40xiBREAL1g/JYqbQMIGRv5d6PG5Jr
         02hP7yYtP+b5wQMGojTaIG6Qb2j7gT4xwgg/xbIhLuuv3oW2oCMThbdwTi11Vi7QrdLF
         vO44JvZxdZOItbtcqxK4v11uOmBGxvGL+N8IzdrfH5WTEj+e8AyHNOu/SHBcrmGCns04
         iZl1/k3DyQKIdgs28Jb/RjPPrc0PXY8RNap+VD2PedxF3hun6HmO3lxHUVytAWUYN8J0
         aBMuXBVXvRDJRNFOaRjEjvNr83prKc0aXxJvKJqwXCDXJ+mmQQ+cIfXknRF9S2j7eSUm
         CJOA==
X-Gm-Message-State: AOJu0YyFvlQQnfrhJ0VBxhpiEZTZML1UFigH6a5PhchYyjAMma5jDIUc
	0cacgwZXlyldOk4A1oJhssMSeNUcMtk8MrybxJflgg==
X-Google-Smtp-Source: AGHT+IEGmpdHWqw4w2snpe2G+qFtVOKWkEX4IPfs05uJV+CjCM2jUsVwu81JYX1gUtN3ZD/+ldATGpVopRS2goYjIbQ=
X-Received: by 2002:a25:b94f:0:b0:d84:d709:7966 with SMTP id
 s15-20020a25b94f000000b00d84d7097966mr2743218ybm.0.1695482772915; Sat, 23 Sep
 2023 08:26:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230921062206.14429-1-jaewon31.kim@samsung.com>
 <CABdmKX1V-yPF260gORh-0LFkL+bDfPhOJteiwBjg1v6rYgrvgg@mail.gmail.com>
 <CGME20230921061944epcas1p2f8a022282709da12840b33c0f5898b5f@epcms1p3>
 <20230921122244.1cbf2d57@gandalf.local.home> <20230922022746epcms1p323c50015241eb01311e7e10579fd4c6c@epcms1p3>
In-Reply-To: <20230922022746epcms1p323c50015241eb01311e7e10579fd4c6c@epcms1p3>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Sat, 23 Sep 2023 08:26:01 -0700
Message-ID: <CABdmKX310260fNEH2MAS+n-17XGMp3uUrZThxefAAvzb43XG-g@mail.gmail.com>
Subject: Re: [PATCH v2] vmscan: add trace events for lru_gen
To: jaewon31.kim@samsung.com
Cc: Steven Rostedt <rostedt@goodmis.org>, "yuzhao@google.com" <yuzhao@google.com>, 
	"kaleshsingh@google.com" <kaleshsingh@google.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 21, 2023 at 7:27=E2=80=AFPM =EA=B9=80=EC=9E=AC=EC=9B=90 <jaewon=
31.kim@samsung.com> wrote:
>
> >On Thu, 21 Sep 2023 09:12:30 -0700
> >"T.J. Mercier" <tjmercier@google.com> wrote:
> >
> >> > +       TP_fast_assign(
> >> > +               __entry->nid =3D nid;
> >> > +               __entry->nr_reclaimed =3D nr_reclaimed;
> >> > +               __entry->nr_dirty =3D stat->nr_dirty;
> >> > +               __entry->nr_writeback =3D stat->nr_writeback;
> >> > +               __entry->nr_congested =3D stat->nr_congested;
> >> > +               __entry->nr_immediate =3D stat->nr_immediate;
> >> > +               __entry->nr_activate0 =3D stat->nr_activate[0];
> >> > +               __entry->nr_activate1 =3D stat->nr_activate[1];
> >> > +               __entry->nr_ref_keep =3D stat->nr_ref_keep;
> >> > +               __entry->nr_unmap_fail =3D stat->nr_unmap_fail;
> >> > +               __entry->priority =3D priority;
> >> > +               __entry->reclaim_flags =3D trace_reclaim_flags(file)=
;
> >> > +       ),
> >> > +
> >> > +       TP_printk("nid=3D%d nr_reclaimed=3D%ld nr_dirty=3D%ld nr_wri=
teback=3D%ld nr_congested=3D%ld nr_immediate=3D%ld nr_activate_anon=3D%d nr=
_activate_file=3D%d nr_ref_keep=3D%ld nr_unmap_fail=3D%ld priority=3D%d fla=
gs=3D%s",
> >>
> >> Many of these values are unsigned so I think many of these format
> >> specifiers should be %lu instead of %ld.
>
> Hello T.J.
> Thank you for your comment
> As you expected I got this from the legacy lru trace.
> I've changed as you recommended.
> Actually I changed isolate_mode, too. Please let me know if this is not a=
ctually needed.
>
Great, looks good to me.
Reviewed-by: T.J. Mercier <tjmercier@google.com>

> --- a/include/trace/events/vmscan.h
> +++ b/include/trace/events/vmscan.h
> @@ -367,7 +367,7 @@ TRACE_EVENT_CONDITION(mm_vmscan_lru_gen_scan,
>          * classzone is previous name of the highest_zoneidx.
>          * Reason not to change it is the ABI requirement of the tracepoi=
nt.
>          */
> -       TP_printk("isolate_mode=3D%d classzone=3D%d order=3D%d nr_request=
ed=3D%lu nr_scanned=3D%lu nr_skipped=3D%lu nr_taken=3D%lu lru=3D%s",
> +       TP_printk("isolate_mode=3D%u classzone=3D%d order=3D%d nr_request=
ed=3D%lu nr_scanned=3D%lu nr_skipped=3D%lu nr_taken=3D%lu lru=3D%s",
>                 __entry->isolate_mode,
>                 __entry->highest_zoneidx,
>                 __entry->order,
> @@ -525,7 +525,7 @@ TRACE_EVENT(mm_vmscan_lru_gen_evict,
>                 __entry->reclaim_flags =3D trace_reclaim_flags(file);
>         ),
>
> -       TP_printk("nid=3D%d nr_reclaimed=3D%ld nr_dirty=3D%ld nr_writebac=
k=3D%ld nr_congested=3D%ld nr_immediate=3D%ld nr_activate_anon=3D%d nr_acti=
vate_file=3D%d nr_ref_keep=3D%ld nr_unmap_fail=3D%ld priority=3D%d flags=3D=
%s",
> +       TP_printk("nid=3D%d nr_reclaimed=3D%lu nr_dirty=3D%lu nr_writebac=
k=3D%lu nr_congested=3D%lu nr_immediate=3D%lu nr_activate_anon=3D%u nr_acti=
vate_file=3D%u nr_ref_keep=3D%lu nr_unmap_fail=3D%lu priority=3D%d flags=3D=
%s",
>                 __entry->nid, __entry->nr_reclaimed,
>                 __entry->nr_dirty, __entry->nr_writeback,
>                 __entry->nr_congested, __entry->nr_immediate,
>
> >
> >Other than this, from the tracing POV:
> >
> >Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>
>
> Hello Steven
> I've appreciated your Reviewed-by, let me take this on my next v3 patch.
>
> >
> >-- Steve
