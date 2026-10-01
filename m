Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A510648592D
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Oct 2026 13:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859786; cv=pass; b=GPx1rlN0Z3yNiNnU5SRB83JaDc2UlavaoCSsE7VVKhZByOqmWCYGnp0HpuDMSBPs+wE6Oiry2BevX05I3NOlFvWqgCkhcBrurKFeHfcJsFqo6PFN3q3Lg0a+vTSHAVZBANXGyATZfOiBWkLrpg2tbWD2Lw+fr5cW3r0Oyc/9A8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859786; c=relaxed/simple;
	bh=+tixK3qzfWgvnUC60slzVW+amwwduAv7za6OU4Pq5lI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o07FT4sgEulWKk1ZHvMh2VoOvyWcTGKKHYL22i4reMtaI1hb4i2RfUKl8kkZJk2dZJ6xGSTjfyjLcjc/noo/OK9Up5r53ZMN5Rl4VrOIt/ZUCkw4h1h+0c6NS8lmCFp+/Nr4dDnHqc4m+xlB1JEONBQWvimBL5eQlB7SiVyW8Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfI0Vat+; arc=pass smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfI0Vat+"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-1431a73fa1eso497665c88.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 01 Oct 2026 06:03:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790859784; cv=none;
        d=google.com; s=arc-20260327;
        b=Co5fRd5HbdoBkqz3uoudfxBFyS5iEErGb+xsL2hWQDAZPBFOpYyWNE4oC8KtZWP9yN
         5oKRsKwFKyD6Z1QjtZAUfc4rzEc5AyP8nUyZSzVMVvwMafv7eje7QrWVq0cevH+f9PyP
         tAy/spjMqP6aA2AOELs9Rs+zCCqS5JqjrbxgdN/mFdPqB2tlBYRgr+lWYy0iiF85Y3L8
         98gBtEiPvDQ0FBxPIvIflbePTlEgO+FM+Ot1IHPBHZMQcGJ1fpzHv3cli1u0kygSalEj
         qny7i2s02EBulGS2mrT6lFjiJ7DM+qG+ujKycUfp+vCKPZCP6WQ7JCiC5a4Rt/PnKgTX
         DWLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+tixK3qzfWgvnUC60slzVW+amwwduAv7za6OU4Pq5lI=;
        fh=l4j7Fu0B+Tge7/JIUVLYMZGlahUWQBZYMgTiX5D4Ugo=;
        b=nRr7lXsXYhnzRsFqw/Y5E+ozVdB2eaV1CnVzURDkO62frCZkZMGeuN/QDNA5QsmkvG
         csmiy0uxvH9mlr1Pp8Yib7p5wmane5EiodDAxcegtbeuylgek7Gr7tyegfqkiwo3lzKg
         X78NS0djyUQoIHAY92o6VlNka/fmp5uw4aoNxEpNQgccq6fyv9zgom4WqZainFEuvBp3
         w3LT6IBXzxPvva4J7Mx/n877oaFT+GJ1ng1NKtKVJXfWJB2mrKV0Z2ashGCz4fdjVZYk
         gkdISw++pQNhJjleokLCadrFRDtCKvO19YXuoq48Ma4RwKsuzkGVIziQkvyJGdT0hcex
         VSmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790859784; x=1791464584; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+tixK3qzfWgvnUC60slzVW+amwwduAv7za6OU4Pq5lI=;
        b=mfI0Vat+4PIeSS7ksYoBICEsdq22OsKzssXvN1tzqdt2hLo8fYcmeMcHuodwoI0kPv
         qXLVTbIOguZCyisOFI+It43OjwVd6Egqt5ZOGgn83R4A/dMoYeYgdsPVcZhG2EeAbyHE
         wqWJSCoUpmyvgmorT/OCtjG6Ead7ETRThEsfqhQN/TZyFYwsh7hGTo+hbP66HcBEiRxb
         TV2yOZTy+1Oh6B7b6GB3caiflVzwfr9OPdisemPgZ8T6C4uCAF5VUD+AYG5ntI48cWHj
         EDt94gCZvPTWOnrJORl3pcT8aAQzxYZjsaSa1UpUU3ue6ULYSCHVNDT7rCpcFut+WF+I
         Hl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790859784; x=1791464584;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+tixK3qzfWgvnUC60slzVW+amwwduAv7za6OU4Pq5lI=;
        b=raPWomJkuE5Cfgw76uQY3T1ADgghsAaHJqFILwVEGUhNlP/ToFUOT6iVkBTG8wRwCh
         MqYJbMs7PNRVIuuHQ7ShPGYJ8icoxEuSQgE8kJ0BdMKgcTtn3uP3bYE3c8qII4q+wQl3
         IomL6rSzqZjE8MUIGLq0QGOvzFdB7a0+QCihlYqEoEx+HumSg4Re95d5Sr2JkNUPEpe/
         YmrSOQdDKvaCeQcN0uABIU/OvwCraHKQLsbt0zqFOl+gHKZ8uHxOOhMHta5pglgQRKwZ
         rmv9VYXTfzYtb8E+R+0j1a+JZX4Ob/xADBuwkrU9yXBIA8aV6zWQhfuLwxwQO4C0PEwQ
         qTmg==
X-Forwarded-Encrypted: i=1; AKwUvBzi1voaOk818ZFd3NdEix7bD6FoaA93c/4SXFgpMz631SM6wSHjDe7SGOY7WXmJMOt4TzZJRfDacBBlSyEFxzf1AGU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIBFKJ5bNVhFXSNNG9dhQuQPomLuBtUWw05Svdig04amE4eH8Rx
	m6FjsQmIzUyWw8awNBYc69Y0ar3nDLHtlqvFlgUajg41WnTac6Zi3T0WS1RzBbO8KBYKrOL9ARe
	hiakB2UgeZPykMaHxUhshn7El1L2919g=
X-Gm-Gg: AYBFou2vvYIR331XGEG1x067ql6YHFPYyVPWI5fbBGQfpLsrrCrJVD7tnAFccDDzclb
	zcy5U+2cHoKF6DzpbiHl7UaqkczkSl93c4cGZln/Kb+Yj3TWhFbE7nJJi3lkQsjR7O7xbng6o8M
	ZF1EuLO43OENfpBE8DtypAjG912iGDb0DeiP/WPYCkiAqvh5+GBymG1Ecz10KMdlc0mnDUuDNNI
	Tpd64GXyzzqaT0PVDMVounHQrn90vNHMYvNTzz+okvOAl87m0TPulUUsz7hGEUsZStBF5kNhH4o
	0QNfWlIzCdNu7DB7D1y/vLa6R9VCduyR5Zil3n6V9CzoqV7OBGjCSHhN02WgsJhHWScJt3Z1U4d
	hS1+Zr2LOHM3EPOzRGPkoirVaaakNzOeeFyZjgGnSSCHPYFCvnD9+nxHLguAj/qGKDjOgY2pK1y
	O35pyShFN6XctuAJ7G86fF1YqThdvdUquIOGdfOyD9OE1HA72zRVQ=
X-Received: by 2002:a05:7301:6192:10b0:34b:101f:cdaf with SMTP id
 5a478bee46e88-34cde6749bbmr8550113eec.1.1790859775900; Thu, 01 Oct 2026
 06:02:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909120210.2488674-1-tomo@flapping.org> <20260930.185028.532667902450882259.tomo@flapping.org>
 <ar4-kOdIs7z6zG6k@google.com> <20261001.210403.2208685315788982617.tomo@flapping.org>
In-Reply-To: <20261001.210403.2208685315788982617.tomo@flapping.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 1 Oct 2026 15:02:40 +0200
X-Gm-Features: AclHuK8TvMu4f1BwqJZ754q4kD8PFo0d3Wz5r_zshbC1-ZfB-xefTekYCfYh8D8
Message-ID: <CANiq72kZyRQR-cxYKGKLHu7CkyOGAy6KrV2PegFSnM7eHizbhA@mail.gmail.com>
Subject: Re: [PATCH v2] rust: add mark_used macro
To: FUJITA Tomonori <tomo@flapping.org>
Cc: aliceryhl@google.com, ojeda@kernel.org, rostedt@goodmis.org, 
	gary@garyguo.net, a.hindborg@kernel.org, acourbot@nvidia.com, 
	bjorn3_gh@protonmail.com, boqun@kernel.org, dakr@kernel.org, 
	daniel.almeida@collabora.com, lossin@kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, tamird@kernel.org, 
	tmgross@umich.edu, work@onurozkan.dev, linux-trace-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, fujita.tomonori@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 2:04=E2=80=AFPM FUJITA Tomonori <tomo@flapping.org> =
wrote:
>
> Miguel, what do you think?

I suggested it due to seeing the multi-line combination of `if false`
and `_ =3D ...`, and the fact that we will probably want to reuse the
combination in other macros. It makes the concept more explicit,
easier to grep, and follows other cases we have created for similar
things like this (e.g. `static_assert!`).

Having said that, I do prefer using plain language instead of macros
where possible/reasonable, i.e. I don't like introducing macros and
more concepts in general just for the sake of it. On the other hand,
sometimes language features aren't the best spellings to be honest
(like the `const _` "abuse") and some people prefer abbreviations
(like the discussion on `SZ_*` constants).

Either way is fine, obviously.

Cheers,
Miguel
