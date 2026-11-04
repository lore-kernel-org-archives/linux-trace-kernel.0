Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793831519;
	b=mUgdvs81I8E0t98jVjm1Xb2fDW+rl9a4QSAvNIqab6fwCIYNbnXg8t4+jmXh8mc2ClAD
	 hkepjyhRT5C0miOngcg3ESlkksZvD8x5bbrzrZ/GGijyxwCG1Kle/KC+Ca6G4qQLG8EFw
	 M2jAi/fl0i/2pYcuBe1ZOmL8+6fIZJ6klBbS5qEJLA9ikG91pug+iCz4WI0M9FIKwdHVz
	 RhQE3DsybAzEWJqpI09TqKUInGOkN1GBmo43yMIyESMaUhE/IqRpMdWHFzbrraG0yHrxY
	 51Gk7LiUPQuO9o9cVApC8cFUXJrJKhp7WMjSAJdzg3Z5nSbNpBp8bGaoMy4r9AUPMyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793831519;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1pY66RTAg4gskpB0/23Dm2MncTkJlPFKDiLc2XwKGdA=;
	b=hENaoPky+efogjNy5Nhx+pSLujT60XphOGhwkWg2UjZX2VYuDEfVRfOMVmRCcHcrD7DY
	 qCpFkanVRBzO2yp5Nua1O1AZTSRSGwjYog8x/4mvGhi8halgBhFcg2P1HWgfYYpUWFxdj
	 p0gXyzpTQNFsBSM9SLA8+2u4kYSX50luiyc6hKT0CS6JBm3nFhAyDrjpPcv1KsfjgtDNu
	 PWAHuB4sw7y6nGoZtVt/GXCypc75azYFG5sfiI2fekvDknnEBS+nROQwlbNNAocvA1ids
	 wa27ujbHGmEGVcwU1VfjYV00cB8C0svf6eIqOJIjIwHtrqhRgeakuQlZmHTGavIXrpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D6q3gpTp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB906606D82E
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Nov 2026 22:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D6q3gpTp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8845A1F00A15;
	Wed,  4 Nov 2026 22:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793831518;
	bh=1pY66RTAg4gskpB0/23Dm2MncTkJlPFKDiLc2XwKGdA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D6q3gpTpKYEmJrHIaehomVhi1poKU/XVJMTpb4cma30HCgRYKwXEi0yg94psAaPV9
	 +jfeWPrBd1TSAnMyF9xk9WcIi0wKWkhiDH8FAKfcEbx0CLASo9cMQC7p5v0MKsj+Pr
	 qiLAT7mWhjo5FcN/Sdq6IfwKEPvwmn763Q8I3DukPb4Kxpexmxi6gJbEuDgYMpXTPg
	 AiBno42Cq1EmQ8F0bRjOdxLrt4o+sV5AedjjqedD/VQt9n/KwEqkLF6QDV2I6+/QXM
	 0AA88mroPgaAl7s0I53yYK/sCANQL2fpCcqCWSqvtUZjRpGZSpWlAWyg9fKJ0c0wXx
	 cHaPLHcrGWwQA==
Message-ID: <sashiko-outbox-198231@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 2/3] mm/migrate: introduce async non-temporal
 migration mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Huan Nguyen" <nhuhuan@google.com>, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, trondmy@kernel.org, anna@kernel.org, ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com, rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, jackmanb@google.com, hannes@cmpxchg.org, shivankg@amd.com
Cc: rientjes@google.com, dave@stgolabs.net, nifan.cxl@gmail.com, fvdl@google.com, jic23@kernel.org, rkodsara@amd.com, bharata@amd.com, sj@kernel.org, weixugc@google.com, xuezhengchu@huawei.com, yiannis@zptcorp.com, yiannis.nikolakop@gmail.com, dimitrios.palyvos@zptcorp.com, alirad.malek@zptcorp.com, ryan.roberts@arm.com, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, "Chuck
 Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>
In-Reply-To: <20261103223025.2482227-3-nhuhuan@google.com>
References: <20260730-rfc-nt-demote-v2-0-452dbe3b5073@zptcorp.com>
 <20261103223025.2482227-1-nhuhuan@google.com>
 <20261103223025.2482227-3-nhuhuan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 22:31:56 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mm/compaction: enum migrate_mode ordering breaks compact_zone() =
async check
--

commit 047765d971a4b565eac5e2dd50bc528791c2e77e
Author: Huan Nguyen <nhuhuan@google.com>

mm/migrate: introduce async non-temporal migration mode

This commit introduces MIGRATE_ASYNC_NONTEMPORAL to migrate cold folios
using non-temporal stores via folio_mc_copy_nt() in __migrate_folio(), and
adds migrate_is_async() to update callers across compaction, NFS, and
migration.

> diff --git a/include/linux/migrate_mode.h b/include/linux/migrate_mode.h
> index 05102d4d2490e..fd752fddc972e 100644
> --- a/include/linux/migrate_mode.h
> +++ b/include/linux/migrate_mode.h
> @@ -12,6 +12,7 @@ enum migrate_mode {
>  	MIGRATE_ASYNC,
>  	MIGRATE_SYNC_LIGHT,
>  	MIGRATE_SYNC,
> +	MIGRATE_ASYNC_NONTEMPORAL,
>  };

[Severity: Medium]
Does placing MIGRATE_ASYNC_NONTEMPORAL after MIGRATE_SYNC in enum
migrate_mode break the relational check in compact_zone()?

In mm/compaction.c, compact_zone() checks (cc->mode < MIGRATE_SYNC) when a
page fails to migrate within a pageblock:

mm/compaction.c:compact_zone() {
    ...
			/*
			 * If an ASYNC or SYNC_LIGHT fails to migrate a page
			 * within the pageblock_order-aligned block and
			 * fast_find_migrateblock may be used then scan the
			 * remainder of the pageblock.
			 * ...
			 */
			if (!pageblock_aligned(cc->migrate_pfn) &&
			    !cc->ignore_skip_hint && !cc->finish_pageblock &&
			    (cc->mode < MIGRATE_SYNC)) {
				cc->finish_pageblock =3D true;
    ...
				goto rescan;
			}
    ...
}

Because MIGRATE_ASYNC_NONTEMPORAL has an enum value greater than
MIGRATE_SYNC, (cc->mode < MIGRATE_SYNC) evaluates to false when compact_zon=
e()
runs with cc->mode =3D=3D MIGRATE_ASYNC_NONTEMPORAL and migration fails
mid-pageblock. That causes compact_zone() to skip setting
cc->finish_pageblock =3D true and jumping to rescan, leaving the pageblock
partially scanned without marking it skip so fast_find_migrateblock() can
repeatedly revisit it.

Should MIGRATE_ASYNC_NONTEMPORAL be placed before MIGRATE_SYNC_LIGHT in enum
migrate_mode (matching the ordering in include/trace/events/migrate.h), or
should compact_zone() check cc->mode !=3D MIGRATE_SYNC like
isolate_migratepages() does?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103223025.2482=
227-1-nhuhuan@google.com?part=3D2
