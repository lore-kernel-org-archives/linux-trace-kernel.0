Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978693BBFAF
	for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Jun 2026 07:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781682577; cv=none; b=WXH3GdtSnsvaiuQQdAwW1FQquWxhrtpntzQJsYlKwHRxN0qEQD9ceg/Zqy4SDK4y6iqRntNdYbov6QROMF5nuY+S1PPAesiE9hlZjSqA9bIrqom2rQB67fElUBqH4xJTdTlz3q4PoF+gsClL3oindXxtw3TbTFxnXeol1xvvCi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781682577; c=relaxed/simple;
	bh=guWX0dE4eNypnv4EH6wbsBgSrxQUTF6+7ftmPMw81cg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O3yOcgpbLZ5Xo3ufsdJLmeQs3I4vEt4L3stwwiKXmkY+DV0LlnwgxR3rB8GtBqzglIxETkpy6+cxhEVLtK0/VwWNjQaaO1QrnkxNnQGfTiSX9cjM1LwqaodvRQGOqAKymavB6rW2D+1sLwON+ltklbTNtw1JYr9pSixoME6iIbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J/VwI2rT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/VwI2rT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781682575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=guWX0dE4eNypnv4EH6wbsBgSrxQUTF6+7ftmPMw81cg=;
	b=J/VwI2rT7s/yFU9+Y/ZTnm9W67uAcQ9lJTWK63Uh3HVSFpgA+QZR/oeC+s3qOGO1Bx636a
	8H+IFhpjAWJrFBwrEZCUBu3jt1FWkyDGJTb7Xx7gFWGVylzBUnjLeA5v8UFiQhzzqVHsca
	wqzlCh9hzJeGUaKZavmAqiVtTxstMdA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-AEBB6yoSPoSZGHj-Mgfdpw-1; Wed, 17 Jun 2026 03:49:34 -0400
X-MC-Unique: AEBB6yoSPoSZGHj-Mgfdpw-1
X-Mimecast-MFC-AGG-ID: AEBB6yoSPoSZGHj-Mgfdpw_1781682573
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-46011aa5000so2574511f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Jun 2026 00:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781682573; x=1782287373;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qnrC2V4pS2DHv+kF7P0/Ub99li8+YXaNw21vBBSsAJc=;
        b=IeaW4Yl41h0x/IgHsDVVPYeOUg+GL19BcRe5C49f/x+EDtM+zOdoQMs4MCbFH9dN5n
         l7TcFC4lB3yw8d6bfjx8ntmO6XEewh23RmVArf2H/37X2icii9ZO6CFMq87JhJGtd4gD
         yBNxz4J10Ej24bk+elZ1AyqWgwifBbQaO9CQh/ctJiWp85HQWVWqgYM7QuP8OLQ/qdpq
         0iEmKFM8gF12UP2H2Qk88emYHACzVMFICZ38rzGEKEKejbZLgcepZ08369am6tet3Q9Y
         VPS3bD58+plM0Wt+012ov5dhuE6bLzJsWz+r0uT/Zsuf/SM4ptFCPKBVMDK9Y68oCWZM
         sIdQ==
X-Forwarded-Encrypted: i=1; AFNElJ/0ADADxI/o1hriIqcY5kor3aMlrSZti2m3Oyqbovy+ScGkycXWPUVdjwlGNVNgrF6mchOaGwfZNnkPCNOgcaaQ2H8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU5CgBDJdVYQnDApY4+D1ynE3LboGy4BVXTKF9i5okOu0rleWC
	AIsHud9fgPo6M7EqT6GRkeoWmpgg1J0ku1+RJgMrmafSC4c4QPh65r0MKlksV59DDZxdGHUnkFR
	IuUgwRx+Va2fByXP65C7GDrXHd3OE3I9wAkdfd0W4x4EzShUraO83WyzOrvD5uyW4/OyV5Xo55g
	==
X-Gm-Gg: Acq92OFmpBgqUr9wwqPzAAa52ydLy6dMoDoKsF1XJNuPpzK9g9JaBPgOOUPcF+XlzRK
	sV4Wj7Q5+xPwk6/JNoA8tNc3wT3gWR0JOJO7vABDqnXCjhPuvk6MEKzE+YaLSLL8MoOZzq4fki2
	vzmgpeRmr6cgv6SCEgerStzKBghA9yExisjMXl1jxqV/X+A0SUE9FxbTsZSXb0qerSa0EgnF6Oa
	z8kAvoeSWFhoRD2WTesebF6CRZqLC83fQDQNMNtt1UjmgJyLtyEtqMyJnad4eKhsKCeIN1jhxQ2
	e+Wsa9PMD1aBAfZXA5mnU5NZurvdv9hkdqFsREvTXQpShPkl5hWjzGjWT2yIdq/DBwYkbIyHEJ3
	LfezNCT/AtmlKAK4=
X-Received: by 2002:a05:600c:a143:b0:490:4b89:5362 with SMTP id 5b1f17b1804b1-492333e2f05mr33180845e9.24.1781682573017;
        Wed, 17 Jun 2026 00:49:33 -0700 (PDT)
X-Received: by 2002:a05:600c:a143:b0:490:4b89:5362 with SMTP id 5b1f17b1804b1-492333e2f05mr33180605e9.24.1781682572547;
        Wed, 17 Jun 2026 00:49:32 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2c473bsm55865403f8f.28.2026.06.17.00.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 00:49:32 -0700 (PDT)
Message-ID: <bd466346234132a353a36aeac988ee707a0df55d.camel@redhat.com>
Subject: Re: [PATCH v3 7/9] rv/tlob: add KUnit tests for the tlob monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Wed, 17 Jun 2026 09:49:30 +0200
In-Reply-To: <d9abf11ee0af54689fce87ab95f8e8f7f5eb233d.1780847473.git.wen.yang@linux.dev>
References: <cover.1780847473.git.wen.yang@linux.dev>
	 <d9abf11ee0af54689fce87ab95f8e8f7f5eb233d.1780847473.git.wen.yang@linux.dev>
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bsU6qSy_MKHflheaDSxdM67fPvUcygx94VvUJukrzsU_1781682573
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-06-08 at 00:13 +0800, wen.yang@linux.dev wrote:
> +/*
> + * Valid add lines return -ENOENT (kern_path() finds no such file in
> the test
> + * environment) rather than 0; a non-(-EINVAL) return confirms the
> format was
> + * accepted by the parser.
> + */
> +static void tlob_parse_valid_accepted(struct kunit *test)
> +{
> +=09char buf[128];
> +=09int i;
> +
> +=09for (i =3D 0; i < ARRAY_SIZE(tlob_parse_valid); i++) {
> +=09=09strscpy(buf, tlob_parse_valid[i], sizeof(buf));
> +=09=09KUNIT_EXPECT_NE(test,
> tlob_create_or_delete_uprobe(buf), -EINVAL);

Can you perhaps add those uprobes for real from this test case?
Unit tests should not touch the system, you usually do that by:=C2=A0

1. stubbing the tested function when it starts doing bad things
2. test with dummy data not attaching anything (not applicable here)
3. test a different function not affecting the system

I think the cleanest here is 3. so you could just kunit test
tlob_parse_uprobe_line() and tlob_parse_remove_line().

Alternatively just stub the entirety of tlob_add_uprobe()
tlob_remove_uprobe_by_key() and maybe even check that they're called
when expected and not called on failure (right now you aren't testing
valid removals, probably because that's going to break).

I believe a good unit test should be validating the parsing logic only
/or/ the add/remove logic (but that's hard, you can skip it or even
check in selftests).
Right now your tests are trying to do both, so you don't know if
failures came from the uprobes subsystem or allocation (you shouln't
even get there from the unit test).

Then you can just check for success and not for ! EINVAL , which is
confusing.

Thanks,
Gabriele

> +=09}
> +}
> +
> +static void tlob_parse_invalid_rejected(struct kunit *test)
> +{
> +=09char buf[128];
> +=09int i;
> +
> +=09for (i =3D 0; i < ARRAY_SIZE(tlob_parse_invalid); i++) {
> +=09=09strscpy(buf, tlob_parse_invalid[i], sizeof(buf));
> +=09=09KUNIT_EXPECT_EQ(test,
> tlob_create_or_delete_uprobe(buf), -EINVAL);
> +=09}
> +}
> +
> +static void tlob_parse_out_of_range_rejected(struct kunit *test)
> +{
> +=09char buf[128];
> +=09int i;
> +
> +=09for (i =3D 0; i < ARRAY_SIZE(tlob_parse_out_of_range); i++) {
> +=09=09strscpy(buf, tlob_parse_out_of_range[i],
> sizeof(buf));
> +=09=09KUNIT_EXPECT_EQ(test,
> tlob_create_or_delete_uprobe(buf), -ERANGE);
> +=09}
> +}
> +
> +static struct kunit_case tlob_parse_cases[] =3D {
> +=09KUNIT_CASE(tlob_parse_valid_accepted),
> +=09KUNIT_CASE(tlob_parse_invalid_rejected),
> +=09KUNIT_CASE(tlob_parse_out_of_range_rejected),
> +=09{}
> +};
> +
> +static struct kunit_suite tlob_parse_suite =3D {
> +=09.name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "tlob_parse",
> +=09.test_cases =3D tlob_parse_cases,
> +};
> +
> +kunit_test_suite(tlob_parse_suite);
> +
> +MODULE_DESCRIPTION("KUnit tests for the tlob RV monitor");
> +MODULE_LICENSE("GPL");

