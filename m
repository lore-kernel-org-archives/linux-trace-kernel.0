Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785F5C77B78
	for <linux-trace-kernel@archiver.kernel.org>; Wed,  3 May 2023 15:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjECPKh (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 3 May 2023 11:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjECPKf (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 3 May 2023 11:10:35 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5660361B2
        for <linux-trace-kernel@vger.kernel.org>; Wed,  3 May 2023 08:10:30 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4eca9c8dd57so1040442e87.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 May 2023 08:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683126628; x=1685718628;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1FOOYbd4dNFDyiEsaPE2X+b61t9SVPlgw+HWMJw8nPQ=;
        b=NCxlBbe0yHp+orLaVoMilefwUbSkmvgou3PONq4ikA9yt8Ne2iagEvZcru+HHSK5X5
         LBk1cHCtTFSIpW1QbOpGzKQv8XkqwNW99AeHImeBDaXVakHkiBSNCP0Z7M9upLhe/HIM
         exqaGNKwY9NA3AVxU1xYMoz3f6Wyh7811YjCyZIDJ6OrAWtrflW2Lq2PpBq7QQlCYTFZ
         VneunO+17q3eV7jPYeIevzebbFtxL0DuqU3OJQC0PsM3LvyKEegD+PNVRoDBSzqC+NVo
         dTtaIJws0AK3VsH5FptgOui5/ddKoVH81G9c5KuISLZ69hg96h30nmAtA61gvzoNEkis
         A7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683126628; x=1685718628;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1FOOYbd4dNFDyiEsaPE2X+b61t9SVPlgw+HWMJw8nPQ=;
        b=eS6iZpUwtWPhmjBXk3bB8NpeJDq+ZXkcYTkRiSvuPWrMz4lQAxFU/rErHEa1vq17z7
         44k1aNMaAQ9gwmJF/F5eezy2LS2CcOPsOk3qdovc0j+ZyFJJ/8tQn5LoyZFNyvoBzpAr
         Oq/0vzajWoj11kgfE5JMWxwqiBIlOelPP//dIpK4fxhO1yxZMiMg94z5FVKqAzKWOkXc
         o2rCbuOKF5DrUhEgCOqKEoDEfiqsK7yN2OweOdEwpr3s9naLzV2jd/OemYdrz2LOBs0E
         nL1CwOmxS0uue/awJjwzPNNPp/igJ1aYhy5yZBf54EVGONw5AbWoLtXrPjq5T183WwdL
         3Dbw==
X-Gm-Message-State: AC+VfDzeaRD0pA2OY3QU/9mONQ+fvtxkMfSmUlbKjBlJH6ZpokVtBx47
        hnqkfEyDn9VjeZT3rOon+yBRiOlv80U=
X-Google-Smtp-Source: ACHHUZ5hE/JhzHwVocGO3sb5keG2LJ35ysmsUethpNftdurDqk9OVoLqNtTbCNq3qNnQQmxZ7zu0Jw==
X-Received: by 2002:ac2:4470:0:b0:4f0:13bb:690 with SMTP id y16-20020ac24470000000b004f013bb0690mr1668939lfl.4.1683126628276;
        Wed, 03 May 2023 08:10:28 -0700 (PDT)
Received: from DESKTOP-BKF2J9E ([203.109.40.79])
        by smtp.gmail.com with ESMTPSA id y27-20020ac2447b000000b004f13d5825c9sm214195lfl.51.2023.05.03.08.10.27
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 03 May 2023 08:10:27 -0700 (PDT)
Message-ID: <64527963.c20a0220.16763.074a@mx.google.com>
Date:   Wed, 03 May 2023 08:10:27 -0700 (PDT)
X-Google-Original-Date: 3 May 2023 20:10:28 +0500
MIME-Version: 1.0
From:   erwinshrader438@gmail.com
To:     linux-trace-kernel@vger.kernel.org
Subject: Estimating Services
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

=0D=0AHi,=0D=0A=0D=0AWe are an estimating firm and offer our serv=
ices to GC's, Sub Contractors and Architects. We perform commerci=
al and residential estimates & takeoffs.=0D=0A=0D=0AIf you have a=
ny job for estimating or designing just send over the project pla=
ns/details after reviewing the drawings, We will give you 85% off=
 market price. You may also ask us for samples of our recent work=
.=0D=0A=0D=0AThanks.=0D=0ARegards,=0D=0AErwin Shrader=0D=0AMarket=
ing Manager=0D=0ACrown Estimation, LLC

